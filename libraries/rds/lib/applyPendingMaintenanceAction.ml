open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ApplyPendingMaintenanceActionMessage =
  struct
    type t =
      {
      resource_identifier: String.t
        [@ocaml.doc
          "<p>The RDS Amazon Resource Name (ARN) of the resource that the pending maintenance action applies to. For information about creating an ARN, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.ARN.html#USER_Tagging.ARN.Constructing\"> Constructing an RDS Amazon Resource Name (ARN)</a>.</p>"];
      apply_action: String.t
        [@ocaml.doc
          "<p>The pending maintenance action to apply to this resource.</p> <p>Valid values: <code>system-update</code>, <code>db-upgrade</code>, <code>hardware-maintenance</code>, <code>ca-certificate-rotation</code> </p>"];
      opt_in_type: String.t
        [@ocaml.doc
          "<p>A value that specifies the type of opt-in request, or undoes an opt-in request. An opt-in request of type <code>immediate</code> can't be undone.</p> <p>Valid values:</p> <ul> <li> <p> <code>immediate</code> - Apply the maintenance action immediately.</p> </li> <li> <p> <code>next-maintenance</code> - Apply the maintenance action during the next maintenance window for the resource.</p> </li> <li> <p> <code>undo-opt-in</code> - Cancel any existing <code>next-maintenance</code> opt-in requests.</p> </li> </ul>"]}
    [@@ocaml.doc "<p/>"]
    let make ~resource_identifier  ~apply_action  ~opt_in_type  () =
      { resource_identifier; apply_action; opt_in_type }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("opt_in_type", (String.to_json v.opt_in_type));
           Some ("apply_action", (String.to_json v.apply_action));
           Some
             ("resource_identifier", (String.to_json v.resource_identifier))])
    let parse xml =
      Some
        {
          resource_identifier =
            (Xml.required "ResourceIdentifier"
               (Util.option_bind (Xml.member "ResourceIdentifier" xml)
                  String.parse));
          apply_action =
            (Xml.required "ApplyAction"
               (Util.option_bind (Xml.member "ApplyAction" xml) String.parse));
          opt_in_type =
            (Xml.required "OptInType"
               (Util.option_bind (Xml.member "OptInType" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "ResourceIdentifier"
                   ([], (String.to_xml v.resource_identifier)))])
            @
            [Some
               (Ezxmlm.make_tag "ApplyAction"
                  ([], (String.to_xml v.apply_action)))])
           @
           [Some
              (Ezxmlm.make_tag "OptInType"
                 ([], (String.to_xml v.opt_in_type)))])
  end[@@ocaml.doc "<p/>"]
module ApplyPendingMaintenanceActionResult =
  ApplyPendingMaintenanceActionResult
type input = ApplyPendingMaintenanceActionMessage.t
type output = ApplyPendingMaintenanceActionResult.t
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
         ("Action", ["ApplyPendingMaintenanceAction"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ApplyPendingMaintenanceActionMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (ApplyPendingMaintenanceActionMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "ApplyPendingMaintenanceActionResponse" (snd xml))
        (Xml.member "ApplyPendingMaintenanceActionResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ApplyPendingMaintenanceActionResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ApplyPendingMaintenanceActionResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ApplyPendingMaintenanceActionResult - missing field in body or children: "
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