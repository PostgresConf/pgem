module Admin
  class PoliciesController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource through: :conference, except: [:new, :create]

    def index
      authorize! :index, Policy.new(conference_id: @conference.id)
      @policies = Policy.where(global: true) | @conference.policies
      @policies_conference = @conference.policies
      @new_policy = @conference.policies.new
    end

    def show
    end

    def new
      @policy = Policy.new(conference_id: @conference.id)
      authorize! :create, @policy
    end

    def create
      @policy = @conference.policies.new(policy_params)
      @policy.conference_id = @conference.id
      authorize! :create, @policy

      respond_to do |format|
        if @conference.save
          format.html { redirect_to admin_conference_policies_path, notice: 'Policy was successfully created.' }
        else
          format.html { redirect_to admin_conference_policies_path, error: "Oops, couldn't save Policy. #{@policy.errors.full_messages.join('. ')}" }
        end
      end
    end

    # GET policies/1/edit
    def edit
      if @policy.global
        redirect_to admin_conference_policies_path(conference_id: @conference.short_title), error: 'Sorry, you cannot edit global policies. Create a new one.'
      end
    end

    # PUT policies/1
    def update
      if @policy.update(policy_params)
        redirect_to admin_conference_policies_path(conference_id: @conference.short_title), notice: "Policy '#{@policy.title}' for #{@conference.short_title} successfully updated."
      else
        redirect_to admin_conference_policies_path(conference_id: @conference.short_title), notice: "Update of policies for #{@conference.short_title} failed. #{@policy.errors.full_messages.join('. ')}"
      end
    end

    # Update policies used for the conference
    def update_conference
      authorize! :update, Policy.new(conference_id: @conference.id)
      if @conference.update(conference_params)
        redirect_to admin_conference_policies_path(conference_id: @conference.short_title), notice: "Policies for #{@conference.short_title} successfully updated."
      else
        redirect_to admin_conference_policies_path(conference_id: @conference.short_title), notice: "Update of policies for #{@conference.short_title} failed."
      end
    end

    # DELETE policies/1
    def destroy
      if can? :destroy, @policy
        # Do not delete global policies
        if @policy.global
          flash[:error] = 'You cannot delete global policies.'
        else
          # Delete policy
          begin
            Policy.transaction do
              @policy.destroy
              flash[:notice] = "Deleted policy: #{@policy.title}"
            end
          rescue ActiveRecord::RecordInvalid
            flash[:error] = 'Could not delete policy.'
          end
        end
      else
        flash[:error] = 'You must be an admin to delete a policy.'
      end

      @policies = Policy.where(global: true).all | Policy.where(conference_id: @conference.id)
      @policies_conference = @conference.policies
    end

    private

    def policy_params
      params.require(:policy).permit(:title, :global, :description, :conference_id)
    end

    def conference_params
      params.require(:conference).permit(policy_ids: [])
    end
  end
end
