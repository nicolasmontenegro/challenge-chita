class Chita < Sinatra::Base

  validations = {
    client_dni: 'required',
    debtor_dni: 'required',
    document_amount: 'required',
    folio: 'required',
    expiration_date: 'required'
  }

  def add_dots (number_to_convert)
    return number_to_convert.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse 
  end


  get '/' do
    "Hello #{params['name']}!"
  end

  get '/challenge' do
    # Validación
    validator = HashValidator.validate(params, validations)

    if not validator.valid?
      # Si no ingresan todos los parámetros
      status 422
      body validator.errors.to_json
    else
      # Consulta API
      response_json = RestClient.get(
        ENV['API_URL'],
        :params => params,
        :'X-Api-Key' => ENV['API_KEY'],
        :accept => :json
      )
      response = JSON.parse(response_json)

      # Calculo Previo
      advance_percentage = (params['document_amount'].to_i * (response['advance_percent'].to_f/100.0))

      # Calculo
      financing_cost = advance_percentage * \
        (((response['document_rate'].to_f / 100.0) / 30.0) * \
        (Date.parse(params['expiration_date'], '%Y-%m-%d') - Date.today).to_i)
      order_to_receive = advance_percentage - \
        (financing_cost + response['commission'].to_f)
      surplus = params['document_amount'].to_i - \
        advance_percentage

      # respuesta
      content_type :json
      return {
        :result => true,
        :params => params,
        :api_response => response,
        :response => {
          :financing_cost => "$#{add_dots(financing_cost.to_i)}",
          :order_to_receive => "$#{add_dots(order_to_receive.to_i)}",
          :surplus => "$#{add_dots(surplus.to_i)}"
        }
      }.to_json
    end
  end
end