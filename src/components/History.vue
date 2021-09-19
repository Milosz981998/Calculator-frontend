<template>

<div>
     <b-table striped hover :fields="fields" :items="items"></b-table>
</div>
</template>

<script>

export default {
    props:{
        refresh:Boolean
    },
    watch:{
        refresh(){
            this.fetchData();
        },
    },  
    data() {
      return {
        items: [],
        fields: [{
          key: "FirstNumber",
          label: "First number"
        },
        {
          key: "Sign",
          label: "Sign"
        },
        {
          key: "SecondNumber",
          label: "Second number"
        },
        {
          key: "Result",
          label: "Result"
        }
      ]
      }
    },
    mounted(){
        this.fetchData();
    },
    methods:{
        fetchData(){
             this.axios.get('/api/calculator').then(({data})=>{
                this.items = data;
            });
        }
    }
  }
</script>
