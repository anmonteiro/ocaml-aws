open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyHostsRequest =
  struct
    type t =
      {
      auto_placement: AutoPlacement.t option
        [@ocaml.doc
          "<p>Specify whether to enable or disable auto-placement.</p>"];
      host_ids: RequestHostIdList.t
        [@ocaml.doc "<p>The IDs of the Dedicated Hosts to modify.</p>"];
      host_recovery: HostRecovery.t option
        [@ocaml.doc
          "<p>Indicates whether to enable or disable host recovery for the Dedicated Host. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-hosts-recovery.html\"> Host Recovery</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      instance_type: String.t option
        [@ocaml.doc
          "<p>Specifies the instance type to be supported by the Dedicated Host. Specify this parameter to modify a Dedicated Host to support only a specific instance type.</p> <p>If you want to modify a Dedicated Host to support multiple instance types in its current instance family, omit this parameter and specify <b>InstanceFamily</b> instead. You cannot specify <b>InstanceType</b> and <b>InstanceFamily</b> in the same request.</p>"];
      instance_family: String.t option
        [@ocaml.doc
          "<p>Specifies the instance family to be supported by the Dedicated Host. Specify this parameter to modify a Dedicated Host to support multiple instance types within its current instance family.</p> <p>If you want to modify a Dedicated Host to support a specific instance type only, omit this parameter and specify <b>InstanceType</b> instead. You cannot specify <b>InstanceFamily</b> and <b>InstanceType</b> in the same request.</p>"]}
    let make ?auto_placement  ~host_ids  ?host_recovery  ?instance_type 
      ?instance_family  () =
      {
        auto_placement;
        host_ids;
        host_recovery;
        instance_type;
        instance_family
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.instance_family
              (fun f -> Query.Pair ("InstanceFamily", (String.to_query f)));
           Util.option_map v.instance_type
             (fun f -> Query.Pair ("InstanceType", (String.to_query f)));
           Util.option_map v.host_recovery
             (fun f -> Query.Pair ("HostRecovery", (HostRecovery.to_query f)));
           Some
             (Query.Pair ("HostId", (RequestHostIdList.to_query v.host_ids)));
           Util.option_map v.auto_placement
             (fun f ->
                Query.Pair ("AutoPlacement", (AutoPlacement.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.instance_family
              (fun f -> ("instance_family", (String.to_json f)));
           Util.option_map v.instance_type
             (fun f -> ("instance_type", (String.to_json f)));
           Util.option_map v.host_recovery
             (fun f -> ("host_recovery", (HostRecovery.to_json f)));
           Some ("host_ids", (RequestHostIdList.to_json v.host_ids));
           Util.option_map v.auto_placement
             (fun f -> ("auto_placement", (AutoPlacement.to_json f)))])
    let parse xml =
      Some
        {
          auto_placement =
            (Util.option_bind (Xml.member "autoPlacement" xml)
               AutoPlacement.parse);
          host_ids =
            (Xml.required "hostId"
               (Util.option_bind (Xml.member "hostId" xml)
                  RequestHostIdList.parse));
          host_recovery =
            (Util.option_bind (Xml.member "HostRecovery" xml)
               HostRecovery.parse);
          instance_type =
            (Util.option_bind (Xml.member "InstanceType" xml) String.parse);
          instance_family =
            (Util.option_bind (Xml.member "InstanceFamily" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.auto_placement
                  (fun f ->
                     Ezxmlm.make_tag "autoPlacement"
                       ([], (AutoPlacement.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "hostId"
                         ([], (RequestHostIdList.to_xml [x])))) v.host_ids))
             @
             [Util.option_map v.host_recovery
                (fun f ->
                   Ezxmlm.make_tag "HostRecovery"
                     ([], (HostRecovery.to_xml f)))])
            @
            [Util.option_map v.instance_type
               (fun f ->
                  Ezxmlm.make_tag "InstanceType" ([], (String.to_xml f)))])
           @
           [Util.option_map v.instance_family
              (fun f ->
                 Ezxmlm.make_tag "InstanceFamily" ([], (String.to_xml f)))])
  end
module ModifyHostsResult = ModifyHostsResult
type input = ModifyHostsRequest.t
type output = ModifyHostsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2016-11-15"]); ("Action", ["ModifyHosts"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyHostsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyHostsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyHostsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ModifyHostsResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ModifyHostsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyHostsResult - missing field in body or children: "
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