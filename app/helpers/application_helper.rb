module ApplicationHelper
  def title(page_title = nil)
    content_for(:title){ page_title }
    page_title
  end

  def flash_alert_type(name)
    case name.to_s
    when "notice"
      "success"
    when "warning"
      "warning"
    when "info"
      "info"
    else
      "danger"
    end
  end

  def validation_errors_notifications(object)
    return '' if object.errors.empty?

    messages = object.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
      <div class="alert alert-danger alert-block validation-errors"> <button type="button"
      class="close" data-dismiss="alert">x</button>
      #{messages}
      </div>
    HTML

    html.html_safe
  end

  def active_list?(list_name, custom_active = nil)
    current = [view_controller, view_action, custom_active]
    if current.include?(list_name)
      true
    else
      false
    end
  end

  def view_controller
    params[:controller].split("/").last
  end

  def view_action
    params[:action]
  end
end

class ActionView::Helpers::FormBuilder
  def preview_image_field field_name
    remove_avatar = ""
    if object.has_image?(field_name)
      remove_avatar = %Q{
        <a href="/settings/remove_avatar?avatar_type=#{field_name.to_s}" class="btn btn-primary" type="button" data-method="put" data-confirm="Remove this picture?">
          <span class="glyphicon glyphicon-remove"></span>
          Remove
        </a>
      }
    end

    %Q{
      <div class="input-group image-preview" data-preview-img="#{object.has_image?(field_name) ? object.send(field_name).url(:medium) : ''}">
        <input class="form-control image-preview-filename" disabled="disabled" type="text"></input>
        <!-- don't give a name === doesn't send on POST/GET -->
        <span class="input-group-btn">
          <!-- image-preview-clear button -->
          <button class="btn btn-default image-preview-clear button" onclick="clearPreviewImage(this);" style="display:none;" type="button">
            <span class="glyphicon glyphicon-remove"></span>
            Clear
          </button>
          #{remove_avatar}
          <!-- image-preview-input-->
          <div class="btn btn-default image-preview-input button">
            <span class="glyphicon glyphicon-folder-open"></span>
            <span class="image-preview-input-title">Browse</span>
            #{file_field field_name.to_sym, accept: "image/png, image/jpeg, image/gif", onchange: "createPreviewImage(this);"}
          </div>
        </span>
      </div>
    }.html_safe
  end
end
