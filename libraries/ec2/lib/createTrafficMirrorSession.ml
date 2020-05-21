open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateTrafficMirrorSessionRequest =
  struct
    type t =
      {
      network_interface_id: String.t
        [@ocaml.doc "<p>The ID of the source network interface.</p>"];
      traffic_mirror_target_id: String.t
        [@ocaml.doc "<p>The ID of the Traffic Mirror target.</p>"];
      traffic_mirror_filter_id: String.t
        [@ocaml.doc "<p>The ID of the Traffic Mirror filter.</p>"];
      packet_length: Integer.t option
        [@ocaml.doc
          "<p>The number of bytes in each packet to mirror. These are bytes after the VXLAN header. Do not specify this parameter when you want to mirror the entire packet. To mirror a subset of the packet, set this to the length (in bytes) that you want to mirror. For example, if you set this value to 100, then the first 100 bytes that meet the filter criteria are copied to the target.</p> <p>If you do not want to mirror the entire packet, use the <code>PacketLength</code> parameter to specify the number of bytes in each packet to mirror.</p>"];
      session_number: Integer.t
        [@ocaml.doc
          "<p>The session number determines the order in which sessions are evaluated when an interface is used by multiple sessions. The first session with a matching filter is the one that mirrors the packets.</p> <p>Valid values are 1-32766.</p>"];
      virtual_network_id: Integer.t option
        [@ocaml.doc
          "<p>The VXLAN ID for the Traffic Mirror session. For more information about the VXLAN protocol, see <a href=\"https://tools.ietf.org/html/rfc7348\">RFC 7348</a>. If you do not specify a <code>VirtualNetworkId</code>, an account-wide unique id is chosen at random.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The description of the Traffic Mirror session.</p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc "<p>The tags to assign to a Traffic Mirror session.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a>.</p>"]}
    let make ~network_interface_id  ~traffic_mirror_target_id 
      ~traffic_mirror_filter_id  ?packet_length  ~session_number 
      ?virtual_network_id  ?description  ?(tag_specifications= [])  ?dry_run 
      ?client_token  () =
      {
        network_interface_id;
        traffic_mirror_target_id;
        traffic_mirror_filter_id;
        packet_length;
        session_number;
        virtual_network_id;
        description;
        tag_specifications;
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
           Some
             (Query.Pair
                ("TagSpecification",
                  (TagSpecificationList.to_query v.tag_specifications)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Util.option_map v.virtual_network_id
             (fun f -> Query.Pair ("VirtualNetworkId", (Integer.to_query f)));
           Some
             (Query.Pair
                ("SessionNumber", (Integer.to_query v.session_number)));
           Util.option_map v.packet_length
             (fun f -> Query.Pair ("PacketLength", (Integer.to_query f)));
           Some
             (Query.Pair
                ("TrafficMirrorFilterId",
                  (String.to_query v.traffic_mirror_filter_id)));
           Some
             (Query.Pair
                ("TrafficMirrorTargetId",
                  (String.to_query v.traffic_mirror_target_id)));
           Some
             (Query.Pair
                ("NetworkInterfaceId",
                  (String.to_query v.network_interface_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("tag_specifications",
               (TagSpecificationList.to_json v.tag_specifications));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.virtual_network_id
             (fun f -> ("virtual_network_id", (Integer.to_json f)));
           Some ("session_number", (Integer.to_json v.session_number));
           Util.option_map v.packet_length
             (fun f -> ("packet_length", (Integer.to_json f)));
           Some
             ("traffic_mirror_filter_id",
               (String.to_json v.traffic_mirror_filter_id));
           Some
             ("traffic_mirror_target_id",
               (String.to_json v.traffic_mirror_target_id));
           Some
             ("network_interface_id",
               (String.to_json v.network_interface_id))])
    let parse xml =
      Some
        {
          network_interface_id =
            (Xml.required "NetworkInterfaceId"
               (Util.option_bind (Xml.member "NetworkInterfaceId" xml)
                  String.parse));
          traffic_mirror_target_id =
            (Xml.required "TrafficMirrorTargetId"
               (Util.option_bind (Xml.member "TrafficMirrorTargetId" xml)
                  String.parse));
          traffic_mirror_filter_id =
            (Xml.required "TrafficMirrorFilterId"
               (Util.option_bind (Xml.member "TrafficMirrorFilterId" xml)
                  String.parse));
          packet_length =
            (Util.option_bind (Xml.member "PacketLength" xml) Integer.parse);
          session_number =
            (Xml.required "SessionNumber"
               (Util.option_bind (Xml.member "SessionNumber" xml)
                  Integer.parse));
          virtual_network_id =
            (Util.option_bind (Xml.member "VirtualNetworkId" xml)
               Integer.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecification" xml)
                  TagSpecificationList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Some
                       (Ezxmlm.make_tag "NetworkInterfaceId"
                          ([], (String.to_xml v.network_interface_id)))])
                   @
                   [Some
                      (Ezxmlm.make_tag "TrafficMirrorTargetId"
                         ([], (String.to_xml v.traffic_mirror_target_id)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "TrafficMirrorFilterId"
                        ([], (String.to_xml v.traffic_mirror_filter_id)))])
                 @
                 [Util.option_map v.packet_length
                    (fun f ->
                       Ezxmlm.make_tag "PacketLength"
                         ([], (Integer.to_xml f)))])
                @
                [Some
                   (Ezxmlm.make_tag "SessionNumber"
                      ([], (Integer.to_xml v.session_number)))])
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
                     (Ezxmlm.make_tag "TagSpecification"
                        ([], (TagSpecificationList.to_xml [x]))))
                v.tag_specifications))
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.client_token
              (fun f -> Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
  end
module CreateTrafficMirrorSessionResult = CreateTrafficMirrorSessionResult
type input = CreateTrafficMirrorSessionRequest.t
type output = CreateTrafficMirrorSessionResult.t
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
         ("Action", ["CreateTrafficMirrorSession"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateTrafficMirrorSessionRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateTrafficMirrorSessionRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateTrafficMirrorSessionResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateTrafficMirrorSessionResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateTrafficMirrorSessionResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateTrafficMirrorSessionResult - missing field in body or children: "
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