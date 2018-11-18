class Offer {
  constructor(offerJSON) {
    this.id = offerJSON.id;
    this.giverId = offerJSON.giver_id;
    this.headline = offerJSON.headline;
    this.city = offerJSON.city;
    this.state = offerJSON.state;
    this.description = offerJSON.description;
    this.availability = offerJSON.availability;
    this.closed = offerJSON.closed;
    this.deleted = offerJSON.deleted;
    this.createdAt = offerJSON.created_at;
    
    this.adapter = new OffersAdapter();

    // if view is offers#show
    if ($('#requests-count').length) {
      // debugger
      this.attachShowRequestsListener();
      this.attachNextPreviousRequestListener();
      this.conditionalRenderRequestForm(this.id);
    }
  }

  attachShowRequestsListener() {
    $('#requests-count').on('click', '.js-requests', (e) => {
      e.preventDefault();
      $('#requests-count').empty();
      this.renderRequests();
    });
  }

  renderRequests() {
    const currId = parseInt($('.js-next').attr('data-id'), 10);
      $('#offer-requests').empty();
      const requestsHtml = $.get(`/offers/${currId}.json`, (data) => {
        const htmlString = data.requests.map(request => {
          const status = request.completed_requestor && request.completed_giver ? 'Closed request' : 'Open request';
          return `
            <div class="lt-grey-box list-spacing">
              <h4 class="slab-font">${status}</h4>
              <b>From: </b>${request.requestor_name}<br>
              <b>Email: </b>${request.requestor_email || 'Email not given'}<br>
              <b>Phone: </b>${request.formatted_phone || 'Phone not given'}<br>
              <b>Message: </b>${request.message}<br>
            </div>
          `;
        }).join('');
        $('#offer-requests').html(htmlString);
      });
  }

  attachNextPreviousRequestListener() {
    $('.js-previous').on('click', (e) => {
      e.preventDefault();
      const prevId = parseInt($('.js-next').attr('data-id'), 10) + 1;
      $('#offer-requests').empty();
      this.changeRenderOffer(prevId);
    });

    $('.js-next').on('click', (e) => {
      e.preventDefault();
      $('#offer-requests').empty();
      const nextId = parseInt($('.js-next').attr('data-id'), 10) - 1;
      this.changeRenderOffer(nextId);
    });
  }

  conditionalRenderRequestForm(theId) {
    // if current user already has a request or owns the offer,don't show link to request form
    const id = theId || parseInt($('.js-next').attr('data-id'), 10);
    this.adapter.getOffer(id).then(offer => {
      const userHasExistingRequest = offer.requests.some(req => req.requestor_id === offer.current_user.id );
      if (userHasExistingRequest || offer.giver_id === offer.current_user.id) {
        $('#show-request-form').empty();
      } else {
        $('#show-request-form').text('Make a request');
        this.attachShowRequestFormListener();
      }
    });
  }

  changeRenderOffer(id) {
    this.adapter.getOffer(id).then(data => {
      const requestsCountHtml = `<a href="/offers/${id}" class="js-requests" data-id="${data.id}">${data.requests.length} requests</a>`;
      $('#requests-count').html(requestsCountHtml);

      const offerStatus = data.closed ? 'Closed offer' : 'Open offer';
      const availability = data.availability ? data.availability : 'Not specified';
      $('#offer-status').text(offerStatus);
      $('#offer-headline').text(data.headline);
      $('#offer-post-date').text(`Posted on ${data.created_date}`);
      $('#offer-description').html(`<b>Description: </b>${data.description}`);
      $('#offer-location').html(`<b>Location: </b>${data.city_state}`);
      $('#offer-availability').html(`<b>Pickup availability: </b>${availability}`);

      $('.js-next').attr('data-id', data.id);
    });
    this.conditionalRenderRequestForm(id);
    $('#request-form').empty();
  }

  attachShowRequestFormListener() {
    $('#show-request-form').on('click', (e) => {
      e.preventDefault();
      $('#show-request-form').html('<h3>New request</h3>');
      $('#place-for-request-form').html(this.renderForm());

      this.attachFormSubmitListener();
    });
  }

  attachFormSubmitListener() {
    $('#request-form').on('submit', (e) => {
      e.preventDefault();
      console.log('submit clicked');
      this.submitForm();
      $('#show-request-form').empty();
      $('#place-for-request-form').empty();
    });
  }

  renderForm() {
    return `
      <form id="request-form">
      <div class="form-group">
        <label for="request-message">Message</label>
        <input type="text" id="request-message" class="form-control">
      </div>
      <p><b>Contact me at (at least one is required):</b></p>
      <div class="form-group">
        <label for="requestor-email">Email</label>
        <input type="text" id="requestor-email" class="form-control">
      </div>
      <div class="form-group">
        <label for="requestor-phone">Phone</label>
        <input type="text" id="requestor-phone" class="form-control">
      </div>
      <input type="submit" class="btn btn-primary">
      <a href="/index" class="btn btn-secondary">Cancel</a>
      </form>
    `;
  }

  submitForm() {
    const id = parseInt($('.js-next').attr('data-id'), 10);
    const data = {
      request: {
        message: $('#request-message')[0].value,
        requestor_email: $('#requestor-email')[0].value,
        requestor_phone: $('#requestor-phone')[0].value
      }
    };

    $.ajax({
     url: `/offers/${id}/requests`,
     dataType: 'json',
     data: data,
     method: 'POST',
     success: this.appendNewRequestDiv(data)
    });
  }

  makeSentence() {
    return `${this.giver_name} is offering ${this.headline} in ${this.location}`;
  }

  appendNewRequestDiv(data) {
    $('#new-request').append(`
      <br>
      <div class="lt-grey-box list-spacing">
        <h4 class="slab-font">Your request</h4>
        <b>Email: </b>${data.request.requestor_email || 'Not given'}<br>
        <b>Phone: </b>${data.request.requestor_phone || 'Not given'}<br>
        <b>Message: </b>${data.request.message}<br>
      </div>
    `);
  }

  renderLi() {
    // if view is offers#show
    const href = $('#requests-count').length ? `/${this.id}` : `/offers/${this.id}`;
    return `
      <li class="list-obj left-padding">
        <h5><a href="${href}">${this.headline}</a></h5>
        <div>${this.city}, ${this.state}</div>
      </li>
    `;
  }
}
