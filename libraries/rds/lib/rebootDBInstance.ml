open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RebootDBInstanceMessage =
  struct
    type t =
      {
      d_b_instance_identifier: String.t
        [@ocaml.doc
          "<p>The DB instance identifier. This parameter is stored as a lowercase string.</p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing DBInstance.</p> </li> </ul>"];
      force_failover: Boolean.t option
        [@ocaml.doc
          "<p> A value that indicates whether the reboot is conducted through a Multi-AZ failover. </p> <p>Constraint: You can't enable force failover if the instance isn't configured for Multi-AZ.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_instance_identifier  ?force_failover  () =
      { d_b_instance_identifier; force_failover }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.force_failover
              (fun f -> ("force_failover", (Boolean.to_json f)));
           Some
             ("d_b_instance_identifier",
               (String.to_json v.d_b_instance_identifier))])
    let parse xml =
      Some
        {
          d_b_instance_identifier =
            (Xml.required "DBInstanceIdentifier"
               (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
                  String.parse));
          force_failover =
            (Util.option_bind (Xml.member "ForceFailover" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "DBInstanceIdentifier"
                  ([], (String.to_xml v.d_b_instance_identifier)))])
           @
           [Util.option_map v.force_failover
              (fun f ->
                 Ezxmlm.make_tag "ForceFailover" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module RebootDBInstanceResult = RebootDBInstanceResult
type input = RebootDBInstanceMessage.t
type output = RebootDBInstanceResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["RebootDBInstance"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RebootDBInstanceMessage.to_query req))))) in
  (`POST, uri, (Headers.render (RebootDBInstanceMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "RebootDBInstanceResponse" (snd xml))
        (Xml.member "RebootDBInstanceResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp RebootDBInstanceResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed RebootDBInstanceResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RebootDBInstanceResult - missing field in body or children: "
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