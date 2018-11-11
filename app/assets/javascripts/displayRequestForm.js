$(() => {
  $('#show-request-form').on('click', e => {
    e.preventDefault();

    const form = `
      <form>
        <label for="request-message">
        <input type="text" id="request-message">
        <input type="submit">
      </form>
    `;

    $('#place-for-form').html(form)
  });
});
