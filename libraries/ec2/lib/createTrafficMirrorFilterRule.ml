open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateTrafficMirrorFilterRuleRequest =
  struct
    type t =
      {
      traffic_mirror_filter_id: String.t
        [@ocaml.doc
          "<p>The ID of the filter that this rule is associated with.</p>"];
      traffic_direction: TrafficDirection.t
        [@ocaml.doc
          "<p>The type of traffic (<code>ingress</code> | <code>egress</code>).</p>"];
      rule_number: Integer.t
        [@ocaml.doc
          "<p>The number of the Traffic Mirror rule. This number must be unique for each Traffic Mirror rule in a given direction. The rules are processed in ascending order by rule number.</p>"];
      rule_action: TrafficMirrorRuleAction.t
        [@ocaml.doc
          "<p>The action to take (<code>accept</code> | <code>reject</code>) on the filtered traffic.</p>"];
      destination_port_range: TrafficMirrorPortRangeRequest.t option
        [@ocaml.doc "<p>The destination port range.</p>"];
      source_port_range: TrafficMirrorPortRangeRequest.t option
        [@ocaml.doc "<p>The source port range.</p>"];
      protocol: Integer.t option
        [@ocaml.doc
          "<p>The protocol, for example UDP, to assign to the Traffic Mirror rule.</p> <p>For information about the protocol value, see <a href=\"https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml\">Protocol Numbers</a> on the Internet Assigned Numbers Authority (IANA) website.</p>"];
      destination_cidr_block: String.t
        [@ocaml.doc
          "<p>The destination CIDR block to assign to the Traffic Mirror rule.</p>"];
      source_cidr_block: String.t
        [@ocaml.doc
          "<p>The source CIDR block to assign to the Traffic Mirror rule.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The description of the Traffic Mirror rule.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a>.</p>"]}
    let make ~traffic_mirror_filter_id  ~traffic_direction  ~rule_number 
      ~rule_action  ?destination_port_range  ?source_port_range  ?protocol 
      ~destination_cidr_block  ~source_cidr_block  ?description  ?dry_run 
      ?client_token  () =
      {
        traffic_mirror_filter_id;
        traffic_direction;
        rule_number;
        rule_action;
        destination_port_range;
        source_port_range;
        protocol;
        destination_cidr_block;
        source_cidr_block;
        description;
        dry_run;
        client_token
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Some
             (Query.Pair
                ("SourceCidrBlock", (String.to_query v.source_cidr_block)));
           Some
             (Query.Pair
                ("DestinationCidrBlock",
                  (String.to_query v.destination_cidr_block)));
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
           Some
             (Query.Pair
                ("RuleAction",
                  (TrafficMirrorRuleAction.to_query v.rule_action)));
           Some (Query.Pair ("RuleNumber", (Integer.to_query v.rule_number)));
           Some
             (Query.Pair
                ("TrafficDirection",
                  (TrafficDirection.to_query v.traffic_direction)));
           Some
             (Query.Pair
                ("TrafficMirrorFilterId",
                  (String.to_query v.traffic_mirror_filter_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Some ("source_cidr_block", (String.to_json v.source_cidr_block));
           Some
             ("destination_cidr_block",
               (String.to_json v.destination_cidr_block));
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
           Some
             ("rule_action", (TrafficMirrorRuleAction.to_json v.rule_action));
           Some ("rule_number", (Integer.to_json v.rule_number));
           Some
             ("traffic_direction",
               (TrafficDirection.to_json v.traffic_direction));
           Some
             ("traffic_mirror_filter_id",
               (String.to_json v.traffic_mirror_filter_id))])
    let parse xml =
      Some
        {
          traffic_mirror_filter_id =
            (Xml.required "TrafficMirrorFilterId"
               (Util.option_bind (Xml.member "TrafficMirrorFilterId" xml)
                  String.parse));
          traffic_direction =
            (Xml.required "TrafficDirection"
               (Util.option_bind (Xml.member "TrafficDirection" xml)
                  TrafficDirection.parse));
          rule_number =
            (Xml.required "RuleNumber"
               (Util.option_bind (Xml.member "RuleNumber" xml) Integer.parse));
          rule_action =
            (Xml.required "RuleAction"
               (Util.option_bind (Xml.member "RuleAction" xml)
                  TrafficMirrorRuleAction.parse));
          destination_port_range =
            (Util.option_bind (Xml.member "DestinationPortRange" xml)
               TrafficMirrorPortRangeRequest.parse);
          source_port_range =
            (Util.option_bind (Xml.member "SourcePortRange" xml)
               TrafficMirrorPortRangeRequest.parse);
          protocol =
            (Util.option_bind (Xml.member "Protocol" xml) Integer.parse);
          destination_cidr_block =
            (Xml.required "DestinationCidrBlock"
               (Util.option_bind (Xml.member "DestinationCidrBlock" xml)
                  String.parse));
          source_cidr_block =
            (Xml.required "SourceCidrBlock"
               (Util.option_bind (Xml.member "SourceCidrBlock" xml)
                  String.parse));
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((([] @
                      [Some
                         (Ezxmlm.make_tag "TrafficMirrorFilterId"
                            ([], (String.to_xml v.traffic_mirror_filter_id)))])
                     @
                     [Some
                        (Ezxmlm.make_tag "TrafficDirection"
                           ([],
                             (TrafficDirection.to_xml v.traffic_direction)))])
                    @
                    [Some
                       (Ezxmlm.make_tag "RuleNumber"
                          ([], (Integer.to_xml v.rule_number)))])
                   @
                   [Some
                      (Ezxmlm.make_tag "RuleAction"
                         ([], (TrafficMirrorRuleAction.to_xml v.rule_action)))])
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
               [Some
                  (Ezxmlm.make_tag "DestinationCidrBlock"
                     ([], (String.to_xml v.destination_cidr_block)))])
              @
              [Some
                 (Ezxmlm.make_tag "SourceCidrBlock"
                    ([], (String.to_xml v.source_cidr_block)))])
             @
             [Util.option_map v.description
                (fun f ->
                   Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.client_token
              (fun f -> Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
  end
module CreateTrafficMirrorFilterRuleResult =
  CreateTrafficMirrorFilterRuleResult
type input = CreateTrafficMirrorFilterRuleRequest.t
type output = CreateTrafficMirrorFilterRuleResult.t
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
         ("Action", ["CreateTrafficMirrorFilterRule"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (CreateTrafficMirrorFilterRuleRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateTrafficMirrorFilterRuleRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateTrafficMirrorFilterRuleResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateTrafficMirrorFilterRuleResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateTrafficMirrorFilterRuleResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateTrafficMirrorFilterRuleResult - missing field in body or children: "
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