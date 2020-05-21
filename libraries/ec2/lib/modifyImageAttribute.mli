(** "<p>Modifies the specified attribute of the specified AMI. You can specify only one attribute at a time. You can use the <code>Attribute</code> parameter to specify the attribute or one of the following parameters: <code>Description</code>, <code>LaunchPermission</code>, or <code>ProductCode</code>.</p> <p>AWS Marketplace product codes cannot be modified. Images with an AWS Marketplace product code cannot be made public.</p> <p>To enable the SriovNetSupport enhanced networking attribute of an image, enable SriovNetSupport on an instance and create an AMI from the instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyImageAttributeRequest :
sig
  type t =
    {
    attribute: String.t option ;
    description: AttributeValue.t option ;
    image_id: String.t ;
    launch_permission: LaunchPermissionModifications.t option ;
    operation_type: OperationType.t option ;
    product_codes: ProductCodeStringList.t ;
    user_groups: UserGroupStringList.t ;
    user_ids: UserIdStringList.t ;
    value: String.t option ;
    dry_run: Boolean.t option }[@@ocaml.doc
                                 "<p>Contains the parameters for ModifyImageAttribute.</p>"]
  val make :
    ?attribute:String.t ->
      ?description:AttributeValue.t ->
        image_id:String.t ->
          ?launch_permission:LaunchPermissionModifications.t ->
            ?operation_type:OperationType.t ->
              ?product_codes:ProductCodeStringList.t ->
                ?user_groups:UserGroupStringList.t ->
                  ?user_ids:UserIdStringList.t ->
                    ?value:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = ModifyImageAttributeRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error