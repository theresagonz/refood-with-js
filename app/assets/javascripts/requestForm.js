$(() => {
  $('#request-form-wrapper').on('submit', '#request-form', (e) => {
  alert('Hi!');
  e.preventDefault();

  const data = {
    request: {
      message: $('#request-message')[0].value,
      requestor_email: $('#requestor-email')[0].value,
      requestor_phone: $('#requestor-phone')[0].value
    }
  };
  console.log(data);
  });
});
