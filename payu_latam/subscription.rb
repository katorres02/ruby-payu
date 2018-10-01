module PayuLatam
  class Subscription < Request
    attr_reader :url, :plan, :client, :card
    attr_accessor :resource, :params

    def initialize(plan, client, callback_url)
      @plan   = plan.resource
      @client = client
      @params = empty_object
      @callback_url = callback_url
      url
    end

    def url
      @url = PayuLatam.base_url + '/rest/v4.9/subscriptions/'
    end

    private

    # con todos los datos existentes
    # NOTA: en la doc de payu hay ejemplo para crear subscripción con tarjeta nueva, plan nuevo y demas
    #   en caso de necesitar ese escenario, remitir a http://developers.payulatam.com/es/api/recurring_payments.html
    #
    # NOTA: se esta agregando un array de tarjetas "@client.cards" en la solicitud, tener cuidado que el array solo
    # contenga una tarjeta, no queremos que se cargue el plan a todas las tarjetas
    def empty_object
      temp_params = {
        "quantity": "1",
        "installments": "1",
        "customer": {
          "id": @client.resource['id'],
          "creditCards": @client.cards
        },
        "plan": {
          "planCode": @plan['planCode']
        }
      }
      temp_params['notifyUrl'] = @callback_url if !@callback_url.nil? && !@callback_url.empty?
      temp_params
    end
  end
end