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
}