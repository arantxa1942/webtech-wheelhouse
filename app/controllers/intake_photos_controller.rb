class IntakePhotosController < ApplicationController
  def destroy
    repair = Repair.find(params[:repair_id])
    repair.intake_photos_attachments.find(params[:id]).purge
    redirect_back_or_to repair_path(repair), status: :see_other,
                        notice: "Photo was removed."
  end
end