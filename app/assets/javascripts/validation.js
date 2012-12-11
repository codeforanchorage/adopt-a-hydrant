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
    } else {
      this.errors.undecorate(element);
    }
  }

  this.required = function(selector) {
    var element = findElement(selector);
    if (element.val() === '') {
      this.errors.decorate(element, "is required");
    } else {
      this.errors.undecorate(element);
    }
  }

  this.password = function(selector) {
    var element = findElement(selector);
    if (element.val().length < 6 || element.val().length > 20) {
      this.errors.decorate(element, "must be 6-20 characters");
    } else {
      this.errors.undecorate(element);
    }
  }

  this.zip = function(selector) {
    var element = findElement(selector);
    if (element.val() != '' && !/^\d{5}(-\d{4})?$/.test(element.val())) {
      this.errors.decorate(element, "is invalid");
    } else {
      this.errors.undecorate(element);
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

  this.undecorate = function(element) {
    parent = element.parent();
    parent.removeClass("error");
    parent.find(".help-block").remove();
  }

  this.undecorateAll = function(element) {
    element.find(".error").removeClass("error");
    element.find(".help-block").remove();
  }
}
