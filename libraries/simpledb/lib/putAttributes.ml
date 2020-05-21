open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutAttributesRequest =
  struct
    type t =
      {
      domain_name: String.t
        [@ocaml.doc
          "The name of the domain in which to perform the operation."];
      item_name: String.t [@ocaml.doc "The name of the item."];
      attributes: ReplaceableAttributeList.t
        [@ocaml.doc "The list of attributes."];
      expected: UpdateCondition.t option
        [@ocaml.doc
          "The update condition which, if specified, determines whether the specified attributes will be updated or not. The update condition must be satisfied in order for this request to be processed and the attributes to be updated."]}
    let make ~domain_name  ~item_name  ~attributes  ?expected  () =
      { domain_name; item_name; attributes; expected }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.expected
              (fun f -> ("expected", (UpdateCondition.to_json f)));
           Some
             ("attributes", (ReplaceableAttributeList.to_json v.attributes));
           Some ("item_name", (String.to_json v.item_name));
           Some ("domain_name", (String.to_json v.domain_name))])
    let parse xml =
      Some
        {
          domain_name =
            (Xml.required "DomainName"
               (Util.option_bind (Xml.member "DomainName" xml) String.parse));
          item_name =
            (Xml.required "ItemName"
               (Util.option_bind (Xml.member "ItemName" xml) String.parse));
          attributes =
            (Xml.required "Attributes" (ReplaceableAttributeList.parse xml));
          expected =
            (Util.option_bind (Xml.member "Expected" xml)
               UpdateCondition.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "DomainName"
                    ([], (String.to_xml v.domain_name)))])
             @
             [Some
                (Ezxmlm.make_tag "ItemName" ([], (String.to_xml v.item_name)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Attributes"
                       ([], (ReplaceableAttributeList.to_xml [x]))))
               v.attributes))
           @
           [Util.option_map v.expected
              (fun f ->
                 Ezxmlm.make_tag "Expected" ([], (UpdateCondition.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutAttributesRequest.t
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
         [("Version", ["2009-04-15"]); ("Action", ["PutAttributes"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (PutAttributesRequest.to_query req))))) in
  (`POST, uri, (Headers.render (PutAttributesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
let parse_error code err =
  let errors =
    [Errors_internal.AttributeDoesNotExist;
    Errors_internal.NumberItemAttributesExceeded;
    Errors_internal.NumberDomainBytesExceeded;
    Errors_internal.NumberDomainAttributesExceeded;
    Errors_internal.NoSuchDomain;
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