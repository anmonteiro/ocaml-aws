open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListDomainsRequest =
  struct
    type t =
      {
      max_number_of_domains: Integer.t option
        [@ocaml.doc
          "The maximum number of domain names you want returned. The range is 1 to 100. The default setting is 100."];
      next_token: String.t option
        [@ocaml.doc
          "A string informing Amazon SimpleDB where to start the next list of domain names."]}
    let make ?max_number_of_domains  ?next_token  () =
      { max_number_of_domains; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_number_of_domains
             (fun f -> ("max_number_of_domains", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          max_number_of_domains =
            (Util.option_bind (Xml.member "MaxNumberOfDomains" xml)
               Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.max_number_of_domains
               (fun f ->
                  Ezxmlm.make_tag "MaxNumberOfDomains"
                    ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module ListDomainsResult = ListDomainsResult
type input = ListDomainsRequest.t
type output = ListDomainsResult.t
type error = Errors_internal.t
let streaming = false
let service = "sdb"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2009-04-15"]); ("Action", ["ListDomains"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ListDomainsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ListDomainsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ListDomainsResponse" (snd xml))
        (Xml.member "ListDomainsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListDomainsResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ListDomainsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListDomainsResult - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
let parse_error code err =
  let errors =
    [Errors_internal.InvalidNextToken; Errors_internal.InvalidParameterValue]
      @ Errors_internal.common in
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