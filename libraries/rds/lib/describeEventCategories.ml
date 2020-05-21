open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeEventCategoriesMessage =
  struct
    type t =
      {
      source_type: String.t option
        [@ocaml.doc
          "<p>The type of source that is generating the events.</p> <p>Valid values: db-instance | db-parameter-group | db-security-group | db-snapshot</p>"];
      filters: FilterList.t
        [@ocaml.doc "<p>This parameter isn't currently supported.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?source_type  ?(filters= [])  () = { source_type; filters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.source_type
             (fun f -> ("source_type", (String.to_json f)))])
    let parse xml =
      Some
        {
          source_type =
            (Util.option_bind (Xml.member "SourceType" xml) String.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filters" xml) FilterList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.source_type
               (fun f -> Ezxmlm.make_tag "SourceType" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Filters" ([], (FilterList.to_xml [x]))))
              v.filters))
  end[@@ocaml.doc "<p/>"]
module EventCategoriesMessage = EventCategoriesMessage
type input = DescribeEventCategoriesMessage.t
type output = EventCategoriesMessage.t
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
         ("Action", ["DescribeEventCategories"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeEventCategoriesMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeEventCategoriesMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeEventCategoriesResponse" (snd xml))
        (Xml.member "DescribeEventCategoriesResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp EventCategoriesMessage.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed EventCategoriesMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing EventCategoriesMessage - missing field in body or children: "
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