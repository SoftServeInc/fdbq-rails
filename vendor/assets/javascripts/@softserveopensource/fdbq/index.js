(function() {
  var TOGGLE_REGEX = /(^show | show | show$)/i;
  var SUCCESS_STATUS_CODE = /^20\d$/;

  function parameterize(object) {
    var parts = [];

    for(var prop in object) {
      parts.push(encodeURIComponent(prop)+"="+encodeURIComponent(object[prop]));
    }

    return parts.join("&");
  }

  function questionID(config) { return (config.name+"").replace(/[^\w\-]+/ig, ""); }

  function queryField(fieldID, instance) {
    return document.querySelector('#'+instance.modalSelector+' [data-id="'+fieldID+'"][data-fdbq="field-container"]');
  }

  function arrayFind(array, prop, value) {
    for(var i = 0; i < array.length; i++) {
      if(array[i] && array[i][prop] === value) return array[i];
    }
  }

  function validField(field, config) {
    var isValid = true;

    if(!field) return false;

    if(config.required && !field.value) isValid = false;

    return isValid;
  }

  function buildField(type, options) {
    var node = document.createElement("div");
    node.className = FdbqClassName("fdbq-field", "-"+type, options.error ? "has-errors" : "");
    node.dataset.fdbq = "field-container";
    node.dataset.id = questionID(options);

    return node;
  }

  function buildInput(type, props, options) {
    var node = document.createElement(type);

    for(var prop in props) {
      node[prop] = props[prop];
    }

    node.className = FdbqClassName("fdbq-input", node.className);
    node.dataset.fdbq = "field";

    return node;
  }

  function httpSubmit(params, instance) {
    if(!instance.config.submit.url) return;

    var xmlHttp = new XMLHttpRequest();

    xmlHttp.onreadystatechange = function() { 
      if(xmlHttp.readyState == 4 && SUCCESS_STATUS_CODE.test(xmlHttp.status)) {
        instance.onCloseClick();
      }
    };

    xmlHttp.open("POST", instance.config.submit.url, true);
    xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xmlHttp.send(parameterize(params));
  }

  function renderModalBody(node, instance) {
    node.appendChild(FdbqModalHead(instance));
    node.appendChild(FdbqModalBody(instance));
  }

  function renderModalFields(container, instance) {
    for(var i = 0; i < instance.config.questions.length; i++) {
      var field = FdbqField(instance.config.questions[i], instance);

      if(!field) continue;

      container.appendChild(field);
    }
  }

  function renderFields(node, instance) {
    if(!Array.isArray(instance.config.questions) || !instance.config.questions.length) return;

    child = document.createElement("div");
    child.className = "fdbq-modal-fields";
    child.id = instance.fieldsContainerSelector;

    renderModalFields(child, instance);

    node.appendChild(child);
  }

  function FdbqFieldsReplaceInvalid(instance) {
    if(!instance.errors || !instance.config || !instance.config.questions) return;

    var fields = document.querySelector('#'+instance.modalSelector+' .fdbq-modal-fields');

    if(!fields) return;

    for(var i = 0; i < instance.errors.length; i++) {
      var fieldID = instance.errors[i];
      var config = arrayFind(instance.config.questions, function(el) { return questionID(el) === fieldID; });
      var field = queryField(fieldID, instance);

      if(!config || !field) continue;

      fields.replaceChild(FdbqField(config, instance), field);
    }
  }

  function FdbqUUID(id) { return id+"-"+Math.random().toString(36).substr(2, 9); };
  function FdbqClassName() {
    var classList = [];

    for(var i = 0; i < arguments.length; i++) {
      if(arguments[i]) classList.push(arguments[i]);
    }

    return classList.join(" ");
  }

  function FdbqFieldsReset(instance) {
    var fields = document.getElementById(instance.fieldsContainerSelector);

    if(!fields) return;

    fields.innerHTML = "";
    renderModalFields(fields, instance);
  }

  function FdbqTextField(config, instance) {
    var child;
    var inputID = questionID(config);
    var node = buildField("text", Object.assign({}, config, { error: instance.errors.indexOf(inputID) >= 0 }));
    var fieldID = FdbqUUID("fdbq-field-text-"+inputID);

    if(config.label) {
      child = document.createElement("label");
      child.innerHTML = (config.required ? '<abbr title="required">*</abbr>' : "")+config.label;
      child.htmlFor = fieldID;

      node.appendChild(child);
    }

    node.appendChild(buildInput("textarea", {
      id: fieldID,
      rows: config.rows ? parseInt(config.rows, 10) : 3,
      value: config.value || "",
      placeholder: config.placeholder
    }, { type: "text", id: inputID }));

    if(config.hint) {
      child = document.createElement("div");
      child.className = "fdbq-field-hint";
      child.innerHTML = config.hint;

      node.appendChild(child);
    }

    return node;
  }

  function FdbqStringField(config, instance) {
    var child;
    var inputID = questionID(config);
    var node = buildField("string", Object.assign({}, config, { error: instance.errors.indexOf(inputID) >= 0 }));
    var fieldID = FdbqUUID("fdbq-field-string-"+inputID);

    if(config.label) {
      child = document.createElement("label");
      child.innerHTML = (config.required ? '<abbr title="required">*</abbr>' : "")+config.label;
      child.htmlFor = fieldID;

      node.appendChild(child);
    }

    node.appendChild(buildInput("input", {
      id: fieldID,
      type: "text",
      rows: config.rows ? parseInt(config.rows, 10) : 3,
      value: config.value || "",
      placeholder: config.placeholder
    }, { error: instance.errors.indexOf(config.id) >= 0, type: "string", id: config.id }));

    if(config.hint) {
      child = document.createElement("div");
      child.className = "fdbq-field-hint";
      child.innerHTML = config.hint;

      node.appendChild(child);
    }

    return node;
  }

  function FdbqField(config, instance) {
    switch(config.type) {
      case "text":
        return FdbqTextField(config, instance);
      default:
        return FdbqStringField(config, instance);
    }
  }

  function FdbqModalHead(instance) {
    var node = document.createElement("div");
    node.className = "fdbq-modal-head";

    // heading;
    var heading = document.createElement("h4");
    heading.innerText = instance.config.modal && instance.config.modal.title || "";

    // close button;
    var closeButton = document.createElement("button");
    closeButton.innerHTML = "&times;";
    closeButton.className = "close";
    closeButton.id = instance.modalCloseSelector;

    node.appendChild(heading);
    node.appendChild(closeButton);

    return node;
  }

  function FdbqModalBodyHeading(instance) {
    if(!instance.config.subHeader) return null;

    var node = document.createElement("div");
    node.className = "fdbq-modal-heading";

    // heading;
    if(instance.config.subHeader.title) {
      var child = document.createElement("h5");
      child.className = "sub-heading";
      child.innerText = instance.config.subHeader.title;

      node.appendChild(child);
    }

    // sub-title;
    if(instance.config.subHeader.description) {
      child = document.createElement("div");
      child.className = "sub-heading-description";
      child.innerHTML = instance.config.subHeader.description;

      node.appendChild(child);
    }

    return node;
  }

  function FdbqActions(instance) {
    var node = document.createElement("div");
    node.className = "fdbq-modal-actions";

    var child = document.createElement("button");
    child.className = "submit";
    child.id = instance.modalSubmitSelector;
    child.innerText = "Submit";

    node.appendChild(child);

    return node;
  }

  function FdbqModalBody(instance) {
    var node = document.createElement("div");
    node.className = "fdbq-modal-body";

    var child = FdbqModalBodyHeading(instance);

    if(child) node.appendChild(child);

    renderFields(node, instance);

    child = FdbqActions(instance);

    if(child) node.appendChild(child);

    return node;
  }

  function FdbqModal(instance) {
    var overlay = document.createElement("div");
    var node = document.createElement("div");
    node.className = "fdbq-modal";
    node.id = instance.modalContainerSelector;

    renderModalBody(node, instance);
    
    overlay.className = "fdbq-modal-overlay";
    overlay.appendChild(node);
    overlay.id = instance.modalSelector;

    return overlay;
  }

  function FdbqAction(instance) {
    var node = document.createElement("button");
    node.className = FdbqClassName("fdbq-toggle", instance.config.placement);
    node.id = instance.buttonSelector;
    node.innerHTML = instance.config.actionHTML || instance.config.actionText || '<i class="fdbq-icon-action"></i>';

    return node;
  }

  window.Fdbq = function(config) {
    this.init = function() {
      var modal = FdbqModal(this);
      var action = FdbqAction(this);

      this.mountNode().appendChild(modal);
      this.mountNode().appendChild(action);

      var button = document.getElementById(this.buttonSelector);
      var closeButton = document.getElementById(this.modalCloseSelector);
      var submitButton = document.getElementById(this.modalSubmitSelector);

      if(button) button.addEventListener("click", this.onActionClick.bind(this));
      if(closeButton) closeButton.addEventListener("click", this.onCloseClick.bind(this));
      if(submitButton) submitButton.addEventListener("click", this.onSubmitClick.bind(this));

    };

    this.mountNode = function() { return document.querySelector(this.config.mountNode) || document.body; };
    this.onActionClick = function(event) {
      var modal = document.getElementById(this.modalSelector);

      if(!modal || TOGGLE_REGEX.test(modal.className)) return;

      modal.className = modal.className+" show";
    };
    this.onCloseClick = function() {
      var modal = document.getElementById(this.modalSelector);

      if(!modal || !TOGGLE_REGEX.test(modal.className)) return;
      modal.className = modal.className.replace(TOGGLE_REGEX, "").trim();
      this.errors = [];
      FdbqFieldsReset(this);
    };
    this.onSubmitClick = function(event) {
      this.errors = [];
      if(!this.config.submit || !this.config.questions) return;

      var callback = typeof(this.config.submit) === "function" ? this.config.submit : httpSubmit;
      var params = {};

      for(var i = 0; i < this.config.questions.length; i++) {
        var q = this.config.questions[i];
        var id = questionID(q);
        var field = document.querySelector('.fdbq-modal-fields [data-id="'+id+'"] [data-fdbq="field"]');

        if(!field) continue;

        if(validField(field, q)) {
          params[q.name] = field.value;
        } else {
          this.errors.push(id);
        }
      }

      if(this.errors.length) {
        FdbqFieldsReplaceInvalid(this);

        return false;
      }

      callback(params, this);

      return true;
    };

    // props;
    this.config = config || {};
    this.errors = [];
    this.identifier = FdbqUUID("fdbq");
    this.buttonSelector = this.identifier+"-button";
    this.modalSelector = this.identifier+"-modal";
    this.modalContainerSelector = this.identifier+"-modal-container";
    this.fieldsContainerSelector = this.identifier+"-fields";
    this.modalCloseSelector = this.modalSelector+"-close";
    this.modalSubmitSelector = this.modalSelector+"-submit";
  };
})();
