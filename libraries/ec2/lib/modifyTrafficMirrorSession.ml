open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyTrafficMirrorSessionRequest =
  struct
    type t =
      {
      traffic_mirror_session_id: String.t
        [@ocaml.doc "<p>The ID of the Traffic Mirror session.</p>"];
      traffic_mirror_target_id: String.t option
        [@ocaml.doc
          "<p>The Traffic Mirror target. The target must be in the same VPC as the source, or have a VPC peering connection with the source.</p>"];
      traffic_mirror_filter_id: String.t option
        [@ocaml.doc "<p>The ID of the Traffic Mirror filter.</p>"];
      packet_length: Integer.t option
        [@ocaml.doc
          "<p>The number of bytes in each packet to mirror. These are bytes after the VXLAN header. To mirror a subset, set this to the length (in bytes) to mirror. For example, if you set this value to 100, then the first 100 bytes that meet the filter criteria are copied to the target. Do not specify this parameter when you want to mirror the entire packet.</p>"];
      session_number: Integer.t option
        [@ocaml.doc
          "<p>The session number determines the order in which sessions are evaluated when an interface is used by multiple sessions. The first session with a matching filter is the one that mirrors the packets.</p> <p>Valid values are 1-32766.</p>"];
      virtual_network_id: Integer.t option
        [@ocaml.doc
          "<p>The virtual network ID of the Traffic Mirror session.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>The description to assign to the Traffic Mirror session.</p>"];
      remove_fields: TrafficMirrorSessionFieldList.t
        [@ocaml.doc
          "<p>The properties that you want to remove from the Traffic Mirror session.</p> <p>When you remove a property from a Traffic Mirror session, the property is set to the default.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~traffic_mirror_session_id  ?traffic_mirror_target_id 
      ?traffic_mirror_filter_id  ?packet_length  ?session_number 
      ?virtual_network_id  ?description  ?(remove_fields= [])  ?dry_run  () =
      {
        traffic_mirror_session_id;
        traffic_mirror_target_id;
        traffic_mirror_filter_id;
        packet_length;
        session_number;
        virtual_network_id;
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
                  (TrafficMirrorSessionFieldList.to_query v.remove_fields)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Util.option_map v.virtual_network_id
             (fun f -> Query.Pair ("VirtualNetworkId", (Integer.to_query f)));
           Util.option_map v.session_number
             (fun f -> Query.Pair ("SessionNumber", (Integer.to_query f)));
           Util.option_map v.packet_length
             (fun f -> Query.Pair ("PacketLength", (Integer.to_query f)));
           Util.option_map v.traffic_mirror_filter_id
             (fun f ->
                Query.Pair ("TrafficMirrorFilterId", (String.to_query f)));
           Util.option_map v.traffic_mirror_target_id
             (fun f ->
                Query.Pair ("TrafficMirrorTargetId", (String.to_query f)));
           Some
             (Query.Pair
                ("TrafficMirrorSessionId",
                  (String.to_query v.traffic_mirror_session_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("remove_fields",
               (TrafficMirrorSessionFieldList.to_json v.remove_fields));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.virtual_network_id
             (fun f -> ("virtual_network_id", (Integer.to_json f)));
           Util.option_map v.session_number
             (fun f -> ("session_number", (Integer.to_json f)));
           Util.option_map v.packet_length
             (fun f -> ("packet_length", (Integer.to_json f)));
           Util.option_map v.traffic_mirror_filter_id
             (fun f -> ("traffic_mirror_filter_id", (String.to_json f)));
           Util.option_map v.traffic_mirror_target_id
             (fun f -> ("traffic_mirror_target_id", (String.to_json f)));
           Some
             ("traffic_mirror_session_id",
               (String.to_json v.traffic_mirror_session_id))])
    let parse xml =
      Some
        {
          traffic_mirror_session_id =
            (Xml.required "TrafficMirrorSessionId"
               (Util.option_bind (Xml.member "TrafficMirrorSessionId" xml)
                  String.parse));
          traffic_mirror_target_id =
            (Util.option_bind (Xml.member "TrafficMirrorTargetId" xml)
               String.parse);
          traffic_mirror_filter_id =
            (Util.option_bind (Xml.member "TrafficMirrorFilterId" xml)
               String.parse);
          packet_length =
            (Util.option_bind (Xml.member "PacketLength" xml) Integer.parse);
          session_number =
            (Util.option_bind (Xml.member "SessionNumber" xml) Integer.parse);
          virtual_network_id =
            (Util.option_bind (Xml.member "VirtualNetworkId" xml)
               Integer.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          remove_fields =
            (Util.of_option []
               (Util.option_bind (Xml.member "RemoveField" xml)
                  TrafficMirrorSessionFieldList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Some
                      (Ezxmlm.make_tag "TrafficMirrorSessionId"
                         ([], (String.to_xml v.traffic_mirror_session_id)))])
                  @
                  [Util.option_map v.traffic_mirror_target_id
                     (fun f ->
                        Ezxmlm.make_tag "TrafficMirrorTargetId"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.traffic_mirror_filter_id
                    (fun f ->
                       Ezxmlm.make_tag "TrafficMirrorFilterId"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.packet_length
                   (fun f ->
                      Ezxmlm.make_tag "PacketLength" ([], (Integer.to_xml f)))])
               @
               [Util.option_map v.session_number
                  (fun f ->
                     Ezxmlm.make_tag "SessionNumber" ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.virtual_network_id
                 (fun f ->
                    Ezxmlm.make_tag "VirtualNetworkId"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.description
                (fun f ->
                   Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "RemoveField"
                       ([], (TrafficMirrorSessionFieldList.to_xml [x]))))
               v.remove_fields))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module ModifyTrafficMirrorSessionResult = ModifyTrafficMirrorSessionResult
type input = ModifyTrafficMirrorSessionRequest.t
type output = ModifyTrafficMirrorSessionResult.t
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
         ("Action", ["ModifyTrafficMirrorSession"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyTrafficMirrorSessionRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyTrafficMirrorSessionRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyTrafficMirrorSessionResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyTrafficMirrorSessionResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyTrafficMirrorSessionResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyTrafficMirrorSessionResult - missing field in body or children: "
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