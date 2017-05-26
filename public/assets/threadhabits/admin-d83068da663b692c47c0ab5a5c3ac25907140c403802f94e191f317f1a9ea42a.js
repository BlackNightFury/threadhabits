(function() {
  var Admin;

  Admin = {};

  Admin.init = function() {
    return Admin.alertUsers.sendAlerts();
  };

  Admin.alertUsers = {
    submitAlerts: function(dialog, form) {
      form.find("input[name='send_to_all']").on("change", function() {
        return $("li#user_alerts_emails_input").toggle();
      });
      return form.on("submit", function(e) {
        var $form, formData;
        e.preventDefault();
        $form = $(this);
        formData = $form.serializeArray();
        if (!$form.find("input[name='send_to_all']").is(":checked")) {
          formData.push({
            name: "send_to_all",
            value: "off"
          });
          formData.push({
            name: "recipient_emails",
            value: $("#recipient_emails").val()
          });
        } else {
          formData.push({
            name: "send_to_all",
            value: "on"
          });
        }
        return $.post($form.attr("action"), formData, function(response) {
          var valid;
          valid = response.status;
          return $.alert({
            title: response.title,
            content: response.message,
            type: response.type,
            buttons: {
              ok: {
                text: 'Ok',
                btnClass: 'btn-red',
                action: function() {}
              }
            }
          });
        }).fail(function(response) {
          $.alert({
            title: "Something went wrong",
            type: "red"
          });
          return false;
        });
      });
    },
    sendAlerts: function() {
      return $("#admin_write_message").click(function(e) {
        e.preventDefault();
        return $.get("/admin/alerts/message.json", function(response) {
          return $.confirm({
            backgroundDismiss: false,
            title: "Send Alerts to Users",
            content: response.html,
            theme: 'material',
            buttons: {
              formSubmit: {
                text: 'Submit',
                btnClass: 'btn-blue',
                action: function() {
                  $("form#write_message_form").submit();
                  return false;
                }
              },
              cancel: {
                text: 'Cancel'
              }
            },
            onContentReady: function() {
              $("select.tagging_select_emails").select2({
                placeholder: "Search User's Emails",
                allowClear: true,
                tags: true
              });
              $("textarea#user_alert_body").froalaEditor({
                charCounterCount: true,
                heightMin: 400,
                heightMax: 450,
                tableMultipleStyles: false,
                dragInline: true,
                imageAllowedTypes: ['jpeg', 'jpg', 'png'],
                imageMove: true,
                fileAllowedTypes: ['image/png', 'image/jpeg', 'image/gif'],
                toolbarButtons: ['bold', 'fontSize', 'strikeThrough', 'fontFamily', 'color', 'italic', 'underline', 'insertImage', 'insertLink', 'undo', 'redo', 'paragraphStyle', '|', 'paragraphFormat', 'align', 'insertTable', 'quote', 'selectAll', 'formatOL', 'formatUL', 'indent', 'outdent', '-']
              });
              return Admin.alertUsers.submitAlerts(this, this.$content.find('form'));
            }
          });
        });
      });
    }
  };

  $(function() {
    return Admin.init();
  });

}).call(this);
