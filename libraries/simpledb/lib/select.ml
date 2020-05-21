open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module SelectRequest =
  struct
    type t =
      {
      select_expression: String.t
        [@ocaml.doc "The expression used to query the domain."];
      next_token: String.t option
        [@ocaml.doc
          "A string informing Amazon SimpleDB where to start the next list of <code>ItemNames</code>."];
      consistent_read: Boolean.t option
        [@ocaml.doc
          "Determines whether or not strong consistency should be enforced when data is read from SimpleDB. If <code>true</code>, any data previously written to SimpleDB will be returned. Otherwise, results will be consistent eventually, and the client may not see data that was written immediately before your read."]}
    let make ~select_expression  ?next_token  ?consistent_read  () =
      { select_expression; next_token; consistent_read }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.consistent_read
              (fun f -> ("consistent_read", (Boolean.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some ("select_expression", (String.to_json v.select_expression))])
    let parse xml =
      Some
        {
          select_expression =
            (Xml.required "SelectExpression"
               (Util.option_bind (Xml.member "SelectExpression" xml)
                  String.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          consistent_read =
            (Util.option_bind (Xml.member "ConsistentRead" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "SelectExpression"
                   ([], (String.to_xml v.select_expression)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.consistent_read
              (fun f ->
                 Ezxmlm.make_tag "ConsistentRead" ([], (Boolean.to_xml f)))])
  end
module SelectResult = SelectResult
type input = SelectRequest.t
type output = SelectResult.t
type error = Errors_internal.t
let streaming = false
let service = "sdb"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2009-04-15"]); ("Action", ["Select"])]
         (Util.drop_empty
            (Uri.query_of_encoded (Query.render (SelectRequest.to_query req))))) in
  (`POST, uri, (Headers.render (SelectRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "SelectResponse" (snd xml))
        (Xml.member "SelectResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp SelectResult.parse)
          (BadResponse
             { body; message = "Could not find well formed SelectResult." })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing SelectResult - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
let parse_error code err =
  let errors =
    [Errors_internal.TooManyRequestedAttributes;
    Errors_internal.RequestTimeout;
    Errors_internal.NoSuchDomain;
    Errors_internal.MissingParameter;
    Errors_internal.InvalidQueryExpression;
    Errors_internal.InvalidNumberValueTests;
    Errors_internal.InvalidNumberPredicates;
    Errors_internal.InvalidNextToken;
    Errors_internal.InvalidParameterValue] @ Errors_internal.common in
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