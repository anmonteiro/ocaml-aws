(** "<p>Modifies the specified attribute of the specified Amazon FPGA Image (AFI).</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyFpgaImageAttributeRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    fpga_image_id: String.t ;
    attribute: FpgaImageAttributeName.t option ;
    operation_type: OperationType.t option ;
    user_ids: UserIdStringList.t ;
    user_groups: UserGroupStringList.t ;
    product_codes: ProductCodeStringList.t ;
    load_permission: LoadPermissionModifications.t option ;
    description: String.t option ;
    name: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      fpga_image_id:String.t ->
        ?attribute:FpgaImageAttributeName.t ->
          ?operation_type:OperationType.t ->
            ?user_ids:UserIdStringList.t ->
              ?user_groups:UserGroupStringList.t ->
                ?product_codes:ProductCodeStringList.t ->
                  ?load_permission:LoadPermissionModifications.t ->
                    ?description:String.t -> ?name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyFpgaImageAttributeResult = ModifyFpgaImageAttributeResult
type input = ModifyFpgaImageAttributeRequest.t
type output = ModifyFpgaImageAttributeResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error