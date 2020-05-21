open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteVPCAssociationAuthorizationRequest =
  struct
    type t =
      {
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>When removing authorization to associate a VPC that was created by one AWS account with a hosted zone that was created with a different AWS account, the ID of the hosted zone.</p>"];
      v_p_c: VPC.t
        [@ocaml.doc
          "<p>When removing authorization to associate a VPC that was created by one AWS account with a hosted zone that was created with a different AWS account, a complex type that includes the ID and region of the VPC.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the request to remove authorization to associate a VPC that was created by one AWS account with a hosted zone that was created with a different AWS account. </p>"]
    let make ~hosted_zone_id  ~v_p_c  () = { hosted_zone_id; v_p_c }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("v_p_c", (VPC.to_json v.v_p_c));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id))])
    let parse xml =
      Some
        {
          hosted_zone_id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          v_p_c =
            (Xml.required "VPC"
               (Util.option_bind (Xml.member "VPC" xml) VPC.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Id" ([], (String.to_xml v.hosted_zone_id)))])
           @ [Some (Ezxmlm.make_tag "VPC" ([], (VPC.to_xml v.v_p_c)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the request to remove authorization to associate a VPC that was created by one AWS account with a hosted zone that was created with a different AWS account. </p>"]
module Output = Aws.BaseTypes.Unit
type input = DeleteVPCAssociationAuthorizationRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/2013-04-01/hostedzone/" ^
                req.DeleteVPCAssociationAuthorizationRequest.hosted_zone_id)
               ^ "/deauthorizevpcassociation")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render
               (DeleteVPCAssociationAuthorizationRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (DeleteVPCAssociationAuthorizationRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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