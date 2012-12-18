module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def show_headers(header_row)
    html = "<tr>"

    header_row.each do |k, v| 
      html += '<th scope="col">'
      html += ( v.to_s || "&nbsp;") + '</th>'
    end

    html += '</tr>'
  end

  def edit_headers(header_row, f)
    html = "<tr>"

    header_row.each do |k, v| 
      html += '<th scope="col">'
      html += '<input id="header_' + k.to_s + '" type="text_field" name="drill[header_row][' + k.to_s + ']" value="' + v.to_s + '" />' 
      html+= '</th>'
    end

    html += '</tr>'
  end

#delete this
  def path_aware_link_to_add_fields(name, f, association, path)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    split_path = path.split('/')
    prefix = split_path[-2] == "views" ?  "" : split_path.last(2).join('/') + "/"
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(prefix + association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
