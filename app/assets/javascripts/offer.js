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
    this.attachShowRequestsListener();
    this.attachNextPreviousRequestListener();
    this.attachShowRequestFormListener();
  }

  attachShowRequestsListener() {
    $('#requests-count').on('click', '.js-requests', (e) => {
      e.preventDefault();
      $('#requests-count').empty();
      
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

  changeRenderOffer(id) {
    $.get(`/offers/${id}.json`, (data) => {
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
  }


  attachShowRequestFormListener () {
    $('#show-request-form').on('click', (e) => {
      e.preventDefault();
      $('#show-request-form').html('<h3>New request</h3>')
      $('#place-for-request-form').html(this.renderForm());

      this.attachFormSubmitListener();
    });
  }

  attachFormSubmitListener() {
    $('#request-form').on('submit', (e) => {
      e.preventDefault();
      this.submitForm();
      $('#show-request-form').empty();
      $('#place-for-request-form').empty();
    })
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
    `
  }

  submitForm() {
    const data = {
      request: {
        message: $('#request-message')[0].value,
        requestor_email: $('#requestor-email')[0].value,
        requestor_phone: $('#requestor-phone')[0].value
      }
    };
    $.post(`/offers/${this.id}/requests`, data, (returnedData) => {
      console.log('data', returnedData);
    }, 'json').catch(() => console.error('error'));
  }

  makeSentence() {
    return `${this.giver_name} is offering ${this.headline} in ${this.location}`
  }

  // renderLi() {
  //   return `
  //     <li class="list-obj left-padding">
  //       <h5><a href="offers/${this.id}">${this.headline}</a></h5>
  //       <div>${this.city}, ${this.state}</div>
  //     </li>
  //   `;
  // }

  // renderInfo() {
  //   $('#offer-description').innerHTML = this.renderLi();
  }
