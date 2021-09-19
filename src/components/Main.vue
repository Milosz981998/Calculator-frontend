<template>
<div>
  <b-tabs content-class="mt-3">
    <b-tab title="Calculator" active>
        <Calculator @refreshHistory="refreshHistory = !refreshHistory"/>
    </b-tab>
    <b-tab title="History">
        <History :refresh="refreshHistory"/>
    </b-tab>
  </b-tabs>
</div>

</template>

<script>
import Calculator from '@/components/Calculator';
import History from '@/components/History'
export default {
    data(){
      return{
        refreshHistory:false
      }
    },
    components:{
        Calculator,
        History
    },
}
</script>


