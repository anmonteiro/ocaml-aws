open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyFleetRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      excess_capacity_termination_policy:
        FleetExcessCapacityTerminationPolicy.t option
        [@ocaml.doc
          "<p>Indicates whether running instances should be terminated if the total target capacity of the EC2 Fleet is decreased below the current size of the EC2 Fleet.</p>"];
      fleet_id: String.t [@ocaml.doc "<p>The ID of the EC2 Fleet.</p>"];
      target_capacity_specification: TargetCapacitySpecificationRequest.t
        [@ocaml.doc "<p>The size of the EC2 Fleet.</p>"]}
    let make ?dry_run  ?excess_capacity_termination_policy  ~fleet_id 
      ~target_capacity_specification  () =
      {
        dry_run;
        excess_capacity_termination_policy;
        fleet_id;
        target_capacity_specification
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("TargetCapacitySpecification",
                   (TargetCapacitySpecificationRequest.to_query
                      v.target_capacity_specification)));
           Some (Query.Pair ("FleetId", (String.to_query v.fleet_id)));
           Util.option_map v.excess_capacity_termination_policy
             (fun f ->
                Query.Pair
                  ("ExcessCapacityTerminationPolicy",
                    (FleetExcessCapacityTerminationPolicy.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("target_capacity_specification",
                (TargetCapacitySpecificationRequest.to_json
                   v.target_capacity_specification));
           Some ("fleet_id", (String.to_json v.fleet_id));
           Util.option_map v.excess_capacity_termination_policy
             (fun f ->
                ("excess_capacity_termination_policy",
                  (FleetExcessCapacityTerminationPolicy.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          excess_capacity_termination_policy =
            (Util.option_bind
               (Xml.member "ExcessCapacityTerminationPolicy" xml)
               FleetExcessCapacityTerminationPolicy.parse);
          fleet_id =
            (Xml.required "FleetId"
               (Util.option_bind (Xml.member "FleetId" xml) String.parse));
          target_capacity_specification =
            (Xml.required "TargetCapacitySpecification"
               (Util.option_bind
                  (Xml.member "TargetCapacitySpecification" xml)
                  TargetCapacitySpecificationRequest.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.excess_capacity_termination_policy
                (fun f ->
                   Ezxmlm.make_tag "ExcessCapacityTerminationPolicy"
                     ([], (FleetExcessCapacityTerminationPolicy.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "FleetId" ([], (String.to_xml v.fleet_id)))])
           @
           [Some
              (Ezxmlm.make_tag "TargetCapacitySpecification"
                 ([],
                   (TargetCapacitySpecificationRequest.to_xml
                      v.target_capacity_specification)))])
  end
module ModifyFleetResult = ModifyFleetResult
type input = ModifyFleetRequest.t
type output = ModifyFleetResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2016-11-15"]); ("Action", ["ModifyFleet"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyFleetRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyFleetRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyFleetResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ModifyFleetResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ModifyFleetResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyFleetResult - missing field in body or children: "
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