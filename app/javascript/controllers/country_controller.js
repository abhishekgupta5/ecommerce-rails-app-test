import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  change(event) {
    // TODO: Get the tag ids in a better way instead of hardcoding
    let delivery_info_target = "delivery-info"
    let submit_button_target = "submit-button"
    let turbo_frame_target = "submit-button-turbo-frame"
    let country = event.target.selectedOptions[0].value
    get(`/orders/delivery_info?turbo_frame_target=${turbo_frame_target}&delivery_info_target=${delivery_info_target}&submit_button_target=${submit_button_target}&country=${country}`, {
      responseKind: "turbo-stream"
    })
  }
}
