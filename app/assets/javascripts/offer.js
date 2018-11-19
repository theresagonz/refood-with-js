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
    this.createdDate = offerJSON.created_date;
    this.createdAgo = offerJSON.created_ago;
    
    this.adapter = new OffersAdapter();
    this.currentUserId = '';
    this.adapter.getCurrentUser().then(user => this.currentUserId = user.id);

    // if view is offers#show
    if ($('#requests-link').length) {
      this.attachShowRequestsHandler();
      this.attachNextPreviousRequestHandler();
      this.conditionalRenderRequestForm(this.id);
    }
  }

  attachShowRequestsHandler() {
    $(document).on('click', '#requests-link', (e) => {
      e.preventDefault();
      $('#new-request').empty();
      this.renderRequests();
    });
  }

  renderRequests() {
    const currId = parseInt($('.js-next').attr('data-id'), 10);
    const requestsHtml = this.adapter.getOffer(currId).then(data => {
      const htmlString = data.requests.reverse().map(request => {
        const status = request.completed_requestor && request.completed_giver ? 'Closed request' : 'Open request';
        let requestHTML = '';

        if (this.currentUserId === request.requestor_id) {
          requestHTML += `<div class="lt-green-box list-spacing">
          <h4 class="slab-font">Your request</h4>`;
        } else {
          requestHTML += `<div class="lt-grey-box list-spacing">
          <h4 class="slab-font">${status}</h4>`;
        }
        requestHTML += `
            <div class="neg-margin-bottom"><b>From: </b>${request.requestor_name}</div>
            <div class="margin-bottom"><b>Message: </b>${request.message}</div>
            <div class="small slab-font"><b>Requested on </b>${request.created_date}</div>
            <div class="small slab-font"><b>Email: </b>${request.requestor_email || 'Ask for email'}</div>
            <div class="small slab-font"><b>Phone: </b>${request.formatted_phone || 'Ask for phone'}</div>
          </div>
        `;
        return requestHTML;
        }).join('');

        $('#new-request').empty();
        $('#offer-requests').html(htmlString);
      });
  }

  attachNextPreviousRequestHandler() {
    $('.js-previous').on('click', (e) => {
      e.preventDefault();
      const prevId = parseInt($('.js-next').attr('data-id'), 10) + 1;
      $('#offer-requests').empty();
      this.changeRenderedOffer(prevId);
    });

    $('.js-next').on('click', (e) => {
      e.preventDefault();
      $('#offer-requests').empty();
      const nextId = parseInt($('.js-next').attr('data-id'), 10) - 1;
      this.changeRenderedOffer(nextId);
    });
  }

  conditionalRenderRequestForm(theId) {
    // if current user already has a request or owns the offer,don't show link to request form
    let id = theId || parseInt($('.js-next').attr('data-id'), 10);
    this.adapter.getOffer(id).then(offer => {
      const userHasExistingRequest = offer.requests.some(req => req.requestor_id === this.currentUserId);

      if (userHasExistingRequest || offer.giver_id === this.currentUserId) {
        $('#show-request-form').empty();
      } else {
        $('#show-request-form').text('Request this item');
        this.attachShowRequestFormHandler();
      }
    });
  }

  changeRenderedOffer(currId) {
    this.adapter.getOffer(currId).then(data => {
      console.log('DATA', data);
      const requestsCountHtml = `<a href="#" data-id="${data.id}" id="requests-count">${data.requests.length} requests</a>`;
      $('#requests-link').html(requestsCountHtml);

      const offerStatus = data.closed ? 'Closed offer' : 'Open offer';
      const availability = data.availability ? data.availability : 'Ask for availability';
      $('#offer-name').html(`<b>From: </b>${data.giver_name}`);
      $('#offer-status').text(offerStatus);
      $('#offer-headline').text(data.headline);
      $('#offer-post-date').text(`Posted on ${data.created_date}`);
      $('#offer-description').html(`<b>Description: </b>${data.description}`);
      $('#offer-location').html(`<b>Location: </b>${data.city_state}`);
      $('#offer-availability').html(`<b>Pickup availability: </b>${availability}`);

      $('.js-next').attr('data-id', data.id);
    });
    this.conditionalRenderRequestForm(currId);
    // clear form and single request
    // (to be replaced with all requests)
    $('#request-form').empty();
    $('#show-request-form').empty();
  }

  attachShowRequestFormHandler() {
    $('#show-request-form').on('click', (e) => {
      e.preventDefault();
      $('#show-request-form').html('<h3>New request</h3>');
      $('#request-form').html(this.renderForm());

      this.attachFormSubmitHandler();
    });
  }

  attachFormSubmitHandler() {
    $('#request-form').on('submit', (e) => {
      e.preventDefault();
      console.log('submit clicked');
      this.submitForm();
      $('#show-request-form').empty();
      $('#request-form').empty();
    });
  }

  renderForm() {
    this.addCancelHandler();
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
      <a href="#" id="js-cancel" class="btn btn-secondary">Cancel</a>
      </form>
    `;
  }

  addCancelHandler() {
    $(document).on('click', '#js-cancel', (e) => {
      e.preventDefault();
      $('#show-request-form').text('Request this item');
      $('#request-form').empty();
    })
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
    const phone = data.request.formatted_phone || 'Ask for phone';
    const email = data.request.requestor_email || 'Ask for email';
    const message = data.request.message;
    $('#new-request').append(`
      <div class="lt-green-box list-spacing">
        <h4 class="slab-font">Your request</h4>
        <b>Email: </b>${email}<br>
        <b>Phone: </b>${phone}<br>
        <b>Message: </b>${message}<br>
      </div>
    `);
    const thisId = parseInt($('.js-next').attr('data-id'), 10);
    this.adapter.getOffer(thisId).then(offer => {
      $('#requests-count').text(`${offer.requests.length} requests`);
    });
  }

  renderLi() {
    // if view is offers#show
    const href = $('#requests-link').length ? `/${this.id}` : `/offers/${this.id}`;
    // debugger
    return `
      <li class="list-obj left-padding">
        <h5><a href="${href}">${this.headline}</a></h5>
        <div class="small grey-text">Posted ${this.createdAgo} ago</div>
        <div>${this.city}, ${this.state}</div>
      </li>
    `;
  }
}
