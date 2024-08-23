<div class="col-md-3">
        <div class="form-group">
          <label for="applicant-name">Applicant Name</label>
          <%= text_field_tag :applicant_name, params[:applicant_name], class: 'form-control', placeholder: 'Enter applicant name' %>
        </div>
      </div>

            applications = applications.where('name LIKE ?', "%#{params[:applicant_name]}%") if params[:applicant_name].present?

