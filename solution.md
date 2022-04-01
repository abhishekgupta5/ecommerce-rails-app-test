This file contains information on how you can test the solution for assignments.  
Either merge the separate 8 PRs or just checkout [this](https://github.com/nebulab/abhishek-gupta-techincal-test/tree/abhishekgupta5/nebulab-complete-assignment) branch which contains the whole solution.

<strong>Note:</strong> The whole solution branch^ is only for a reference and not for review.

You'll need to build the project using the steps in README.md first.
  
#### Delivery estimates: Adding shipping methods for countries
Start rails console
> bundle exec rails console  
  
Adding a shipping method for a country  
>ShippingMethod.add({ name: "fedex", delivery_time_in_days: 5, country: "IN" })  
  
Adding a shipping method for multiple countries  
> ShippingMethod.add_for_countries("fedex", {"DE": 2, "IN": 4})  
  
<strong>Note:</strong> A country can have at most one shipping method. Adding more will result in an error.

#### Showing delivery estimates on checkout and summary page
Now you can try to place the order by completing the checkout flow and see the delivery info for these countries on checkout page and summary page. Also, you won't be able to place orders for countries for whom a shipping method is not added.

Order creation for non-deliverable countries won't happen even if you are not using the form/UI.

--------
#### ERP integration

Once an order is complete, you'd be able to view ERP data via this command -
> ErpDatum.where(order_id: order_id)

You can check the entity id being saved along with order id.

-----
You can check [this](https://www.dropbox.com/s/wnehft4eqx4zi7s/nebulab_assignment_walkthrough.mov?dl=0) 3 mins video to see the above in action.
