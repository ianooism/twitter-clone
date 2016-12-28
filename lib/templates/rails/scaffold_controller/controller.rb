<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  def index
    render :index, locals: { <%= plural_table_name %>: <%= orm_class.all(class_name) %> }
  end
  
  def show
    render :show, locals: { <%= singular_table_name %>: current_<%= singular_table_name %> }
  end
  
  def new
    render :new, locals: { <%= singular_table_name %>: new_<%= singular_table_name %> }
  end
  
  def create
    if new_<%= singular_table_name %>.update(<%= "#{singular_table_name}_form_params" %>)
      redirect_to <%= index_helper %>_url, notice: <%= %Q("#{human_name} created.") %>
    else
      render :new, locals: { <%= singular_table_name %>: new_<%= singular_table_name %> }
    end
  end
  
  def edit
    render :edit, locals: { <%= singular_table_name %>: current_<%= singular_table_name %> }
  end
  
  def update
    if current_<%= singular_table_name %>.update(<%= "#{singular_table_name}_form_params" %>)
      redirect_to <%= index_helper %>_url, notice: <%= %Q("#{human_name} updated.") %>
    else
      render :edit, locals: { <%= singular_table_name %>: current_<%= singular_table_name %> }
    end
  end
  
  def destroy
    current_<%= singular_table_name %>.destroy
    redirect_to <%= index_helper %>_url, notice: <%= %Q("#{human_name} destroyed.") %>
  end
  
  private
    def current_<%= singular_table_name %>
      @<%= singular_table_name %> ||= <%= orm_class.find(class_name, "params[:id]") %>
    end
    
    def new_<%= singular_table_name %>
      @<%= singular_table_name %> ||= <%= orm_class.build(class_name, "new_#{singular_table_name}_params") %>
    end
    
    def <%= "new_#{singular_table_name}_params" %>
    end
    
    def <%= "#{singular_table_name}_form_params" %>
      <%- if attributes_names.empty? -%>
      params.fetch(:<%= singular_table_name %>, {})
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
