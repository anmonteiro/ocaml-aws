open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifySpotFleetRequestRequest =
  struct
    type t =
      {
      excess_capacity_termination_policy:
        ExcessCapacityTerminationPolicy.t option
        [@ocaml.doc
          "<p>Indicates whether running Spot Instances should be terminated if the target capacity of the Spot Fleet request is decreased below the current size of the Spot Fleet.</p>"];
      spot_fleet_request_id: String.t
        [@ocaml.doc "<p>The ID of the Spot Fleet request.</p>"];
      target_capacity: Integer.t option
        [@ocaml.doc "<p>The size of the fleet.</p>"];
      on_demand_target_capacity: Integer.t option
        [@ocaml.doc "<p>The number of On-Demand Instances in the fleet.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for ModifySpotFleetRequest.</p>"]
    let make ?excess_capacity_termination_policy  ~spot_fleet_request_id 
      ?target_capacity  ?on_demand_target_capacity  () =
      {
        excess_capacity_termination_policy;
        spot_fleet_request_id;
        target_capacity;
        on_demand_target_capacity
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.on_demand_target_capacity
              (fun f ->
                 Query.Pair ("OnDemandTargetCapacity", (Integer.to_query f)));
           Util.option_map v.target_capacity
             (fun f -> Query.Pair ("TargetCapacity", (Integer.to_query f)));
           Some
             (Query.Pair
                ("SpotFleetRequestId",
                  (String.to_query v.spot_fleet_request_id)));
           Util.option_map v.excess_capacity_termination_policy
             (fun f ->
                Query.Pair
                  ("ExcessCapacityTerminationPolicy",
                    (ExcessCapacityTerminationPolicy.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.on_demand_target_capacity
              (fun f -> ("on_demand_target_capacity", (Integer.to_json f)));
           Util.option_map v.target_capacity
             (fun f -> ("target_capacity", (Integer.to_json f)));
           Some
             ("spot_fleet_request_id",
               (String.to_json v.spot_fleet_request_id));
           Util.option_map v.excess_capacity_termination_policy
             (fun f ->
                ("excess_capacity_termination_policy",
                  (ExcessCapacityTerminationPolicy.to_json f)))])
    let parse xml =
      Some
        {
          excess_capacity_termination_policy =
            (Util.option_bind
               (Xml.member "excessCapacityTerminationPolicy" xml)
               ExcessCapacityTerminationPolicy.parse);
          spot_fleet_request_id =
            (Xml.required "spotFleetRequestId"
               (Util.option_bind (Xml.member "spotFleetRequestId" xml)
                  String.parse));
          target_capacity =
            (Util.option_bind (Xml.member "targetCapacity" xml) Integer.parse);
          on_demand_target_capacity =
            (Util.option_bind (Xml.member "OnDemandTargetCapacity" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.excess_capacity_termination_policy
                 (fun f ->
                    Ezxmlm.make_tag "excessCapacityTerminationPolicy"
                      ([], (ExcessCapacityTerminationPolicy.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "spotFleetRequestId"
                   ([], (String.to_xml v.spot_fleet_request_id)))])
            @
            [Util.option_map v.target_capacity
               (fun f ->
                  Ezxmlm.make_tag "targetCapacity" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.on_demand_target_capacity
              (fun f ->
                 Ezxmlm.make_tag "OnDemandTargetCapacity"
                   ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for ModifySpotFleetRequest.</p>"]
module ModifySpotFleetRequestResponse = ModifySpotFleetRequestResponse
type input = ModifySpotFleetRequestRequest.t
type output = ModifySpotFleetRequestResponse.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["ModifySpotFleetRequest"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifySpotFleetRequestRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifySpotFleetRequestRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifySpotFleetRequestResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifySpotFleetRequestResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifySpotFleetRequestResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifySpotFleetRequestResponse - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
let parse_error code err =
  let errors = [] @ Errors_internal.common in
  match Errors_internal.of_string err with
  | Some v ->
      if
        (List.mem v errors) &&
          ((match Errors_internal.to_http_code v with
            | Some x -> x = code
            | None -> true))
      then Some v
      else None
  | None -> None