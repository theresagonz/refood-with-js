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
    this.addShowRequestFormListener();
  }

  addShowRequestFormListener () {
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
   }, 'json').fail(() => console.error('error'));
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
