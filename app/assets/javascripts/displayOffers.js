$(() => {
  console.log('page loaded')
  $('.js-next').on('click', (e) => {
    e.preventDefault();
    
    $('#offer-requests').empty();

    const nextId = parseInt($('.js-next').attr('data-id')) + 1;
    console.log('next', nextId)
    
    $.get(`/offers/${nextId}.json`, (data) => {
      const requestsCountHtml = `<a href="/offers/${nextId}" class="js-requests" data-id="${data['id']}">${data['requests'].length} requests</a>`

      $('#requests-count').html(requestsCountHtml);
      
      const offerStatus = data['closed'] ? 'Closed offer' : 'Open offer';
      
      const availability = data['availability'] ? data['availability'] : 'Not specified'
      $('#offer-status').text(offerStatus);

      $('#offer-headline').text(data['headline']);
      $('#offer-post-date').text(`Posted on ${data['created_date']}`);
      $('#offer-description').html(`<b>Description: </b>${data['description']}`);
      $('#offer-location').html(`<b>Location: </b>${data['city_state']}`);
      $('#offer-availability').html(`<b>Pickup availability: </b>${availability}`);

      $('.js-next').attr('data-id', data['id']);
    });
  });
})