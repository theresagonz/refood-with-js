class Offer {
  constructor(offerJSON) {
    this.id = offerJSON.id;
    this.giver_id = offerJSON.giver_id;
    this.headline = offerJSON.headline;
    this.city = offerJSON.city;
    this.state = offerJSON.state;
    this.description = offerJSON.description;
    this.availability = offerJSON.availability;
    this.closed = offerJSON.closed;
    this.deleted = offerJSON.deleted;
    this.created_at = offerJSON.created_at;
  }

  renderLi() {
    return `
        <li class="list-obj left-padding">
          <h5><a href="offers/${this.id}">${this.headline}</a></h5>
          <div class="small grey-text">Posted a while ago</div>
          <div>${this.city}, ${this.state}</div>
        </li>
    `;
  }
}