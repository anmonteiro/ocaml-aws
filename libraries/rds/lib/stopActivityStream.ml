open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module StopActivityStreamRequest =
  struct
    type t =
      {
      resource_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the DB cluster for the database activity stream. For example, <code>arn:aws:rds:us-east-1:12345667890:cluster:das-cluster</code>. </p>"];
      apply_immediately: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether or not the database activity stream is to stop as soon as possible, regardless of the maintenance window for the database.</p>"]}
    let make ~resource_arn  ?apply_immediately  () =
      { resource_arn; apply_immediately }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.apply_immediately
              (fun f -> ("apply_immediately", (Boolean.to_json f)));
           Some ("resource_arn", (String.to_json v.resource_arn))])
    let parse xml =
      Some
        {
          resource_arn =
            (Xml.required "ResourceArn"
               (Util.option_bind (Xml.member "ResourceArn" xml) String.parse));
          apply_immediately =
            (Util.option_bind (Xml.member "ApplyImmediately" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ResourceArn"
                  ([], (String.to_xml v.resource_arn)))])
           @
           [Util.option_map v.apply_immediately
              (fun f ->
                 Ezxmlm.make_tag "ApplyImmediately" ([], (Boolean.to_xml f)))])
  end
module StopActivityStreamResponse = StopActivityStreamResponse
type input = StopActivityStreamRequest.t
type output = StopActivityStreamResponse.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["StopActivityStream"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (StopActivityStreamRequest.to_query req))))) in
  (`POST, uri, (Headers.render (StopActivityStreamRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "StopActivityStreamResponse" (snd xml))
        (Xml.member "StopActivityStreamResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp StopActivityStreamResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed StopActivityStreamResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing StopActivityStreamResponse - missing field in body or children: "
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