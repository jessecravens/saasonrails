# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.avatar-form-link').on 'click', ->
    $('#avatar-form').show()
    $('#no-avatar').hide()

  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  
  $('form#new_company').submit ->
    $('input[type=submit]').prop('disabled', true)
    if $('#card_number').length
      subscription.processCard()
      false
    else
      true

subscription =  
  processCard: ->  
    card =  
      number: $('#card_number').val()  
      cvc: $('#card_code').val()  
      expMonth: $('#card_month').val()  
      expYear: $('#card_year').val()  
    Stripe.createToken(card, this.handleStripeResponse)  
    
  handleStripeResponse: (status, response) ->
    if status == 200
      $('#subscription_stripe_card_token').val(response.id)
      $('form#new_company')[0].submit()  
    else
      $('#stripe_error').text(response.error.message)  
      $('input[type=submit]').prop('disabled', false)