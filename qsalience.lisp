;; Simple model to show blending in action.
;; Load the model and call run to see the 
;; trace of two blended retrievals.  The
;; second one will usually fail because
;; it will be below the retrieval threshold.
;;
;; This is a simple case without partial
;; matching enabled and demonstrating both
;; a numeric value blending and a chunk based 
;; blending.


(clear-all)
(require-extra "blending")

(define-model test-blending
    (sgp :sim-hook "similarity_function"
         ;:blending-request-hook "new_blend_request"
         :tmp 1.0
         ;:seed (1 1) :bll nil :blc 5 :mp 1 :v t :blt t :esc t :ans .25 :rt -5)
         :seed (1 1) :bll nil :blc 5 :mp 1 :v t :blt t :esc t :ans nil :rt -5 :value->mag second)

  
  (chunk-type observation highest_obstacle_altitude hazard_level closeness_to_hiker heading_to_hiker current_altitude current_heading)
  
  (chunk-type decision highest_obstacle_altitude hazard_level closeness_to_hiker heading_to_hiker current_altitude current_heading action)
  
  

  
  (p p1
     =imaginal>
       highest_obstacle_altitude =HOA
       hazard_level =HL
       closeness_to_hiker =CTH
       heading_to_hiker =HH
       current_altitude =CA
       current_heading =CH
     ?blending>
       state free
       buffer empty
       error nil
     ==>
     @imaginal>
     +blending>
       isa decision
       highest_obstacle_altitude =HOA
       hazard_level =HL
       closeness_to_hiker =CTH
       heading_to_hiker =HH
       current_altitude =CA
       current_heading =CH)

  
  (p p2
     =blending>
       isa decision
       action =action
     ?blending>
       state free
     ==>
     ;!output! (blended value is =val)
     
     ; Overwrite the blended chunk to erase it and keep it 
     ; from being added to dm.  Not necessary, but keeps the 
     ; examples simpler.
     
     @blending>    
     
     ;;+blending>
     ;;  isa target
     ;;  key key-2)
     )
  )

