class Export::Create < Trailblazer::Operation
  include Model
  model Export, :create

  def create_model(params)
    Export.new(params[:object_name].titleize.constantize)
  end

  contract do
    property :model_fields, virtual: true

    validate do |form| # TODO: doesn't validate association keys
      forbidden_fields = (form.model_fields - model.allowed_fields)
      next if forbidden_fields.size == 0
      errors.add(:base, "Forbidden fields provided: #{forbidden_fields}")
    end
  end

  def process(params)
    # clean params of empty array entries
    params[:export].keys.each do |key|
      params[:export][key].reject!(&:empty?)
    end

    validate(params[:export]) do |form_object|
      form_object.model.requested_fields = params[:export]
    end
  end
end