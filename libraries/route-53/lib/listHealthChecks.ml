open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListHealthChecksRequest =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>If the value of <code>IsTruncated</code> in the previous response was <code>true</code>, you have more health checks. To get another group, submit another <code>ListHealthChecks</code> request. </p> <p>For the value of <code>marker</code>, specify the value of <code>NextMarker</code> from the previous response, which is the ID of the first health check that Amazon Route 53 will return if you submit another request.</p> <p>If the value of <code>IsTruncated</code> in the previous response was <code>false</code>, there are no more health checks to get.</p>"];
      max_items: String.t option
        [@ocaml.doc
          "<p>The maximum number of health checks that you want <code>ListHealthChecks</code> to return in response to the current request. Amazon Route 53 returns a maximum of 100 items. If you set <code>MaxItems</code> to a value greater than 100, Route 53 returns only the first 100 health checks. </p>"]}
    [@@ocaml.doc
      "<p>A request to retrieve a list of the health checks that are associated with the current AWS account.</p>"]
    let make ?marker  ?max_items  () = { marker; max_items }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> Query.Pair ("maxitems", (String.to_query f)));
           Util.option_map v.marker
             (fun f -> Query.Pair ("marker", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> ("max_items", (String.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "marker" xml) String.parse);
          max_items =
            (Util.option_bind (Xml.member "maxitems" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "marker" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_items
              (fun f -> Ezxmlm.make_tag "maxitems" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A request to retrieve a list of the health checks that are associated with the current AWS account.</p>"]
module ListHealthChecksResponse = ListHealthChecksResponse
type input = ListHealthChecksRequest.t
type output = ListHealthChecksResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/healthcheck"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListHealthChecksRequest.to_query req)))) in
  (`GET, uri, (Headers.render (ListHealthChecksRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise
            (Failure "Could not find well formed ListHealthChecksResponse.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListHealthChecksResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListHealthChecksResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListHealthChecksResponse - missing field in body or children: "
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