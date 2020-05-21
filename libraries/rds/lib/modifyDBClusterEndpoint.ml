open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyDBClusterEndpointMessage =
  struct
    type t =
      {
      d_b_cluster_endpoint_identifier: String.t
        [@ocaml.doc
          "<p>The identifier of the endpoint to modify. This parameter is stored as a lowercase string.</p>"];
      endpoint_type: String.t option
        [@ocaml.doc
          "<p>The type of the endpoint. One of: <code>READER</code>, <code>WRITER</code>, <code>ANY</code>.</p>"];
      static_members: StringList.t
        [@ocaml.doc
          "<p>List of DB instance identifiers that are part of the custom endpoint group.</p>"];
      excluded_members: StringList.t
        [@ocaml.doc
          "<p>List of DB instance identifiers that aren't part of the custom endpoint group. All other eligible instances are reachable through the custom endpoint. Only relevant if the list of static members is empty.</p>"]}
    let make ~d_b_cluster_endpoint_identifier  ?endpoint_type 
      ?(static_members= [])  ?(excluded_members= [])  () =
      {
        d_b_cluster_endpoint_identifier;
        endpoint_type;
        static_members;
        excluded_members
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("excluded_members", (StringList.to_json v.excluded_members));
           Some ("static_members", (StringList.to_json v.static_members));
           Util.option_map v.endpoint_type
             (fun f -> ("endpoint_type", (String.to_json f)));
           Some
             ("d_b_cluster_endpoint_identifier",
               (String.to_json v.d_b_cluster_endpoint_identifier))])
    let parse xml =
      Some
        {
          d_b_cluster_endpoint_identifier =
            (Xml.required "DBClusterEndpointIdentifier"
               (Util.option_bind
                  (Xml.member "DBClusterEndpointIdentifier" xml) String.parse));
          endpoint_type =
            (Util.option_bind (Xml.member "EndpointType" xml) String.parse);
          static_members =
            (Util.of_option []
               (Util.option_bind (Xml.member "StaticMembers" xml)
                  StringList.parse));
          excluded_members =
            (Util.of_option []
               (Util.option_bind (Xml.member "ExcludedMembers" xml)
                  StringList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "DBClusterEndpointIdentifier"
                    ([], (String.to_xml v.d_b_cluster_endpoint_identifier)))])
             @
             [Util.option_map v.endpoint_type
                (fun f ->
                   Ezxmlm.make_tag "EndpointType" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "StaticMembers"
                       ([], (StringList.to_xml [x])))) v.static_members))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ExcludedMembers"
                      ([], (StringList.to_xml [x])))) v.excluded_members))
  end
module DBClusterEndpoint = DBClusterEndpoint
type input = ModifyDBClusterEndpointMessage.t
type output = DBClusterEndpoint.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["ModifyDBClusterEndpoint"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyDBClusterEndpointMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyDBClusterEndpointMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "ModifyDBClusterEndpointResponse" (snd xml))
        (Xml.member "ModifyDBClusterEndpointResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DBClusterEndpoint.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DBClusterEndpoint."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DBClusterEndpoint - missing field in body or children: "
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