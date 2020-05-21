open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateDomainRequest =
  struct
    type t =
      {
      domain_name: String.t
        [@ocaml.doc
          "The name of the domain to create. The name can range between 3 and 255 characters and can contain the following characters: a-z, A-Z, 0-9, '_', '-', and '.'."]}
    let make ~domain_name  () = { domain_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("domain_name", (String.to_json v.domain_name))])
    let parse xml =
      Some
        {
          domain_name =
            (Xml.required "DomainName"
               (Util.option_bind (Xml.member "DomainName" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "DomainName"
                 ([], (String.to_xml v.domain_name)))])
  end
module Output = Aws.BaseTypes.Unit
type input = CreateDomainRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "sdb"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2009-04-15"]); ("Action", ["CreateDomain"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateDomainRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateDomainRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
let parse_error code err =
  let errors =
    [Errors_internal.NumberDomainsExceeded;
    Errors_internal.MissingParameter;
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