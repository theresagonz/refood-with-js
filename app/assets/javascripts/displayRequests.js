$(function() {
  $('#requests-count').on('click', '.js-requests', (e) => {
    e.preventDefault();
    
    $('#requests-count').empty();
    
    const id = parseInt($('.js-next').attr('data-id'), 10);
    const requestsHtml = $.get(`/offers/${id}.json`, (data) => {
      const htmlString = data.requests.map(request => {
        const status = request.completed_requestor && request.completed_giver ? 'Closed request' : 'Open request';
        const phone = request.requestor_phone ? request.formatted_phone : 'Phone not given';
        const email = request.requestor_email ? request.requestor_email : 'Email not given';

        return `
          <div class="lt-grey-box list-spacing">
            <h4 class="slab-font">${status}</h4>
            <b>From: </b>${request.requestor_name}<br>
            <b>Email: </b><a href="mailto:${email}">${email}</a><br>
            <b>Phone: </b>${phone}<br>
            <b>Message: </b>${request.message}<br>
          </div>
        `;
        }).join('');

      $('#offer-requests').html(htmlString);
    });
  });
});
