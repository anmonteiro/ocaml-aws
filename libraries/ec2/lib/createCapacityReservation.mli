(** "<p>Creates a new Capacity Reservation with the specified attributes.</p> <p>Capacity Reservations enable you to reserve capacity for your Amazon EC2 instances in a specific Availability Zone for any duration. This gives you the flexibility to selectively add capacity reservations and still get the Regional RI discounts for that usage. By creating Capacity Reservations, you ensure that you always have access to Amazon EC2 capacity when you need it, for as long as you need it. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-capacity-reservations.html\">Capacity Reservations</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>Your request to create a Capacity Reservation could fail if Amazon EC2 does not have sufficient capacity to fulfill the request. If your request fails due to Amazon EC2 capacity constraints, either try again at a later time, try in a different Availability Zone, or request a smaller capacity reservation. If your application is flexible across instance types and sizes, try to create a Capacity Reservation with different instance attributes.</p> <p>Your request could also fail if the requested quantity exceeds your On-Demand Instance limit for the selected instance type. If your request fails due to limit constraints, increase your On-Demand Instance limit for the required instance type and try again. For more information about increasing your instance limits, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-resource-limits.html\">Amazon EC2 Service Limits</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateCapacityReservationRequest :
sig
  type t =
    {
    client_token: String.t option ;
    instance_type: String.t ;
    instance_platform: CapacityReservationInstancePlatform.t ;
    availability_zone: String.t option ;
    availability_zone_id: String.t option ;
    tenancy: CapacityReservationTenancy.t option ;
    instance_count: Integer.t ;
    ebs_optimized: Boolean.t option ;
    ephemeral_storage: Boolean.t option ;
    end_date: DateTime.t option ;
    end_date_type: EndDateType.t option ;
    instance_match_criteria: InstanceMatchCriteria.t option ;
    tag_specifications: TagSpecificationList.t ;
    dry_run: Boolean.t option }
  val make :
    ?client_token:String.t ->
      instance_type:String.t ->
        instance_platform:CapacityReservationInstancePlatform.t ->
          ?availability_zone:String.t ->
            ?availability_zone_id:String.t ->
              ?tenancy:CapacityReservationTenancy.t ->
                instance_count:Integer.t ->
                  ?ebs_optimized:Boolean.t ->
                    ?ephemeral_storage:Boolean.t ->
                      ?end_date:DateTime.t ->
                        ?end_date_type:EndDateType.t ->
                          ?instance_match_criteria:InstanceMatchCriteria.t ->
                            ?tag_specifications:TagSpecificationList.t ->
                              ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateCapacityReservationResult = CreateCapacityReservationResult
type input = CreateCapacityReservationRequest.t
type output = CreateCapacityReservationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error