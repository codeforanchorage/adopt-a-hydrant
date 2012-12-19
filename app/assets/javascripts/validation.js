function Validator(form) {
  this.form = form;
  this.invalidElements = [];
  this.errors = new Errors(this.invalidElements);
  this.errors.undecorateAll(form);
  var that = this;

  function findElement(selector) {
    return that.form.find(selector);
  }

  this.email = function(selector) {
    var element = findElement(selector);
    if (!/[\w\.%\+]+@[\w]+\.+[\w]{2,}/.test(element.val())) {
      this.errors.decorate(element, "is not a valid email");
    }
  }

  this.required = function(selector) {
    var element = findElement(selector);
    if (element.val() === '') {
      this.errors.decorate(element, "is required");
    }
  }

  this.password = function(selector) {
    var element = findElement(selector);
    if (element.val().length < 6 || element.val().length > 20) {
      this.errors.decorate(element, "must be 6-20 characters");
    }
  }

  this.zip = function(selector) {
    var element = findElement(selector);
    if (element.val() != '' && !/^\d{5}(-\d{4})?$/.test(element.val())) {
      this.errors.decorate(element, "is invalid");
    }
  }
}

function Errors(elements) {
  this.elements = typeof elements !== 'undefined' ? elements : [];

  this.decorate = function(element, message) {
    this.elements.push(element);
    element.parent().addClass("error");
    element.after("<span class='help-block'>" + message + "<span>");
  }

  this.undecorateAll = function(element) {
    element.find(".error").removeClass("error");
    element.find(".help-block").remove();
  }
}
