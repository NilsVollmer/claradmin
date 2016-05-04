# frozen_string_literal: true
class Backend::IndexHeaderCell < Cell::Concept
  property :name

  def show
    render
  end

  private

  def pluralized_name
    name.downcase.pluralize
  end

  def current_path
    request.fullpath
  end

  def current_search_input_value
    params[:search]
  end

  def header_link_paths
    link_array = [self_referential_link, new_object_link, export_link]
    options[:additional_links]&.each do |link|
      link_array.push(path: send("#{link}_path"), anchor: link.to_s.titleize)
    end
    link_array
  end

  def header_link link
    link_to link[:anchor], link[:path]
  end

  def self_referential_link
    { path: send("#{pluralized_name}_path"), anchor: 'Liste' }
  end

  def new_object_link
    { path: send("new_#{name.downcase}_path"), anchor: 'Neuet Teil' }
  end

  def export_link
    { path: new_export_path(object_name: name.downcase), anchor: 'Export' }
  end

  def active_class link
    'active' if link[:path] == current_path
  end
end