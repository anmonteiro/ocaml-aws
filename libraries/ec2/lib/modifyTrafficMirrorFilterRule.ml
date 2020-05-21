open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyTrafficMirrorFilterRuleRequest =
  struct
    type t =
      {
      traffic_mirror_filter_rule_id: String.t
        [@ocaml.doc "<p>The ID of the Traffic Mirror rule.</p>"];
      traffic_direction: TrafficDirection.t option
        [@ocaml.doc
          "<p>The type of traffic (<code>ingress</code> | <code>egress</code>) to assign to the rule.</p>"];
      rule_number: Integer.t option
        [@ocaml.doc
          "<p>The number of the Traffic Mirror rule. This number must be unique for each Traffic Mirror rule in a given direction. The rules are processed in ascending order by rule number.</p>"];
      rule_action: TrafficMirrorRuleAction.t option
        [@ocaml.doc "<p>The action to assign to the rule.</p>"];
      destination_port_range: TrafficMirrorPortRangeRequest.t option
        [@ocaml.doc
          "<p>The destination ports that are associated with the Traffic Mirror rule.</p>"];
      source_port_range: TrafficMirrorPortRangeRequest.t option
        [@ocaml.doc
          "<p>The port range to assign to the Traffic Mirror rule.</p>"];
      protocol: Integer.t option
        [@ocaml.doc
          "<p>The protocol, for example TCP, to assign to the Traffic Mirror rule.</p>"];
      destination_cidr_block: String.t option
        [@ocaml.doc
          "<p>The destination CIDR block to assign to the Traffic Mirror rule.</p>"];
      source_cidr_block: String.t option
        [@ocaml.doc
          "<p>The source CIDR block to assign to the Traffic Mirror rule.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>The description to assign to the Traffic Mirror rule.</p>"];
      remove_fields: TrafficMirrorFilterRuleFieldList.t
        [@ocaml.doc
          "<p>The properties that you want to remove from the Traffic Mirror filter rule.</p> <p>When you remove a property from a Traffic Mirror filter rule, the property is set to the default.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~traffic_mirror_filter_rule_id  ?traffic_direction  ?rule_number
       ?rule_action  ?destination_port_range  ?source_port_range  ?protocol 
      ?destination_cidr_block  ?source_cidr_block  ?description 
      ?(remove_fields= [])  ?dry_run  () =
      {
        traffic_mirror_filter_rule_id;
        traffic_direction;
        rule_number;
        rule_action;
        destination_port_range;
        source_port_range;
        protocol;
        destination_cidr_block;
        source_cidr_block;
        description;
        remove_fields;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("RemoveField",
                  (TrafficMirrorFilterRuleFieldList.to_query v.remove_fields)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Util.option_map v.source_cidr_block
             (fun f -> Query.Pair ("SourceCidrBlock", (String.to_query f)));
           Util.option_map v.destination_cidr_block
             (fun f ->
                Query.Pair ("DestinationCidrBlock", (String.to_query f)));
           Util.option_map v.protocol
             (fun f -> Query.Pair ("Protocol", (Integer.to_query f)));
           Util.option_map v.source_port_range
             (fun f ->
                Query.Pair
                  ("SourcePortRange",
                    (TrafficMirrorPortRangeRequest.to_query f)));
           Util.option_map v.destination_port_range
             (fun f ->
                Query.Pair
                  ("DestinationPortRange",
                    (TrafficMirrorPortRangeRequest.to_query f)));
           Util.option_map v.rule_action
             (fun f ->
                Query.Pair
                  ("RuleAction", (TrafficMirrorRuleAction.to_query f)));
           Util.option_map v.rule_number
             (fun f -> Query.Pair ("RuleNumber", (Integer.to_query f)));
           Util.option_map v.traffic_direction
             (fun f ->
                Query.Pair
                  ("TrafficDirection", (TrafficDirection.to_query f)));
           Some
             (Query.Pair
                ("TrafficMirrorFilterRuleId",
                  (String.to_query v.traffic_mirror_filter_rule_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("remove_fields",
               (TrafficMirrorFilterRuleFieldList.to_json v.remove_fields));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.source_cidr_block
             (fun f -> ("source_cidr_block", (String.to_json f)));
           Util.option_map v.destination_cidr_block
             (fun f -> ("destination_cidr_block", (String.to_json f)));
           Util.option_map v.protocol
             (fun f -> ("protocol", (Integer.to_json f)));
           Util.option_map v.source_port_range
             (fun f ->
                ("source_port_range",
                  (TrafficMirrorPortRangeRequest.to_json f)));
           Util.option_map v.destination_port_range
             (fun f ->
                ("destination_port_range",
                  (TrafficMirrorPortRangeRequest.to_json f)));
           Util.option_map v.rule_action
             (fun f -> ("rule_action", (TrafficMirrorRuleAction.to_json f)));
           Util.option_map v.rule_number
             (fun f -> ("rule_number", (Integer.to_json f)));
           Util.option_map v.traffic_direction
             (fun f -> ("traffic_direction", (TrafficDirection.to_json f)));
           Some
             ("traffic_mirror_filter_rule_id",
               (String.to_json v.traffic_mirror_filter_rule_id))])
    let parse xml =
      Some
        {
          traffic_mirror_filter_rule_id =
            (Xml.required "TrafficMirrorFilterRuleId"
               (Util.option_bind (Xml.member "TrafficMirrorFilterRuleId" xml)
                  String.parse));
          traffic_direction =
            (Util.option_bind (Xml.member "TrafficDirection" xml)
               TrafficDirection.parse);
          rule_number =
            (Util.option_bind (Xml.member "RuleNumber" xml) Integer.parse);
          rule_action =
            (Util.option_bind (Xml.member "RuleAction" xml)
               TrafficMirrorRuleAction.parse);
          destination_port_range =
            (Util.option_bind (Xml.member "DestinationPortRange" xml)
               TrafficMirrorPortRangeRequest.parse);
          source_port_range =
            (Util.option_bind (Xml.member "SourcePortRange" xml)
               TrafficMirrorPortRangeRequest.parse);
          protocol =
            (Util.option_bind (Xml.member "Protocol" xml) Integer.parse);
          destination_cidr_block =
            (Util.option_bind (Xml.member "DestinationCidrBlock" xml)
               String.parse);
          source_cidr_block =
            (Util.option_bind (Xml.member "SourceCidrBlock" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          remove_fields =
            (Util.of_option []
               (Util.option_bind (Xml.member "RemoveField" xml)
                  TrafficMirrorFilterRuleFieldList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((([] @
                      [Some
                         (Ezxmlm.make_tag "TrafficMirrorFilterRuleId"
                            ([],
                              (String.to_xml v.traffic_mirror_filter_rule_id)))])
                     @
                     [Util.option_map v.traffic_direction
                        (fun f ->
                           Ezxmlm.make_tag "TrafficDirection"
                             ([], (TrafficDirection.to_xml f)))])
                    @
                    [Util.option_map v.rule_number
                       (fun f ->
                          Ezxmlm.make_tag "RuleNumber"
                            ([], (Integer.to_xml f)))])
                   @
                   [Util.option_map v.rule_action
                      (fun f ->
                         Ezxmlm.make_tag "RuleAction"
                           ([], (TrafficMirrorRuleAction.to_xml f)))])
                  @
                  [Util.option_map v.destination_port_range
                     (fun f ->
                        Ezxmlm.make_tag "DestinationPortRange"
                          ([], (TrafficMirrorPortRangeRequest.to_xml f)))])
                 @
                 [Util.option_map v.source_port_range
                    (fun f ->
                       Ezxmlm.make_tag "SourcePortRange"
                         ([], (TrafficMirrorPortRangeRequest.to_xml f)))])
                @
                [Util.option_map v.protocol
                   (fun f ->
                      Ezxmlm.make_tag "Protocol" ([], (Integer.to_xml f)))])
               @
               [Util.option_map v.destination_cidr_block
                  (fun f ->
                     Ezxmlm.make_tag "DestinationCidrBlock"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.source_cidr_block
                 (fun f ->
                    Ezxmlm.make_tag "SourceCidrBlock" ([], (String.to_xml f)))])
             @
             [Util.option_map v.description
                (fun f ->
                   Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "RemoveField"
                       ([], (TrafficMirrorFilterRuleFieldList.to_xml [x]))))
               v.remove_fields))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module ModifyTrafficMirrorFilterRuleResult =
  ModifyTrafficMirrorFilterRuleResult
type input = ModifyTrafficMirrorFilterRuleRequest.t
type output = ModifyTrafficMirrorFilterRuleResult.t
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
         ("Action", ["ModifyTrafficMirrorFilterRule"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ModifyTrafficMirrorFilterRuleRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyTrafficMirrorFilterRuleRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyTrafficMirrorFilterRuleResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyTrafficMirrorFilterRuleResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyTrafficMirrorFilterRuleResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyTrafficMirrorFilterRuleResult - missing field in body or children: "
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