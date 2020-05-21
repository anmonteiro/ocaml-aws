open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyDBClusterParameterGroupMessage =
  struct
    type t =
      {
      d_b_cluster_parameter_group_name: String.t
        [@ocaml.doc
          "<p>The name of the DB cluster parameter group to modify.</p>"];
      parameters: ParametersList.t
        [@ocaml.doc
          "<p>A list of parameters in the DB cluster parameter group to modify.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_cluster_parameter_group_name  ~parameters  () =
      { d_b_cluster_parameter_group_name; parameters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("parameters", (ParametersList.to_json v.parameters));
           Some
             ("d_b_cluster_parameter_group_name",
               (String.to_json v.d_b_cluster_parameter_group_name))])
    let parse xml =
      Some
        {
          d_b_cluster_parameter_group_name =
            (Xml.required "DBClusterParameterGroupName"
               (Util.option_bind
                  (Xml.member "DBClusterParameterGroupName" xml) String.parse));
          parameters =
            (Xml.required "Parameters"
               (Util.option_bind (Xml.member "Parameters" xml)
                  ParametersList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "DBClusterParameterGroupName"
                  ([], (String.to_xml v.d_b_cluster_parameter_group_name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Parameters"
                      ([], (ParametersList.to_xml [x])))) v.parameters))
  end[@@ocaml.doc "<p/>"]
module DBClusterParameterGroupNameMessage =
  DBClusterParameterGroupNameMessage
type input = ModifyDBClusterParameterGroupMessage.t
type output = DBClusterParameterGroupNameMessage.t
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
         ("Action", ["ModifyDBClusterParameterGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ModifyDBClusterParameterGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyDBClusterParameterGroupMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "ModifyDBClusterParameterGroupResponse" (snd xml))
        (Xml.member "ModifyDBClusterParameterGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DBClusterParameterGroupNameMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DBClusterParameterGroupNameMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DBClusterParameterGroupNameMessage - missing field in body or children: "
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