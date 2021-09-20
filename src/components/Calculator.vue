<template>
  <div class="calculator">
    <div class="calculator__container">
        <div class="display"><input class="display-numbers" id="display" :value="current" disabled="disabled" /></div>
        <div class="keyboard">
            <div class="keyboard-row">
                <button class="keyboard-key keyboard-key--gray" @click="clearDisplay()">AC</button>
                <button class="keyboard-key keyboard-key--gray" @click="changeSign()"><span>+/-</span>
                </button>
                <button class="keyboard-key keyboard-key--gray" @click="convertPercent()">%</button>
                <button class="keyboard-key keyboard-key--orange" @click="handleSign('/')">÷</button></div>
            <div class="keyboard-row">
                <button class="number keyboard-key keyboard-key--white" @click="appendSymbol('7')">7</button>
                <button class="number keyboard-key keyboard-key--white" @click="appendSymbol('8')">8</button>
                <button class="number keyboard-key keyboard-key--white" @click="appendSymbol('9')">9</button>
                <button class="keyboard-key keyboard-key--orange" @click="handleSign('*')">×</button>
            </div>
            <div class="keyboard-row">
                <button class="number keyboard-key keyboard-key--white" @click="appendSymbol('4')">4</button>
                <button class="number keyboard-key keyboard-key--white" @click="appendSymbol('5')">5</button>
                <button class="number keyboard-key keyboard-key--white" @click="appendSymbol('6')">6</button>
                <button class="keyboard-key keyboard-key--orange" @click="handleSign('-')">−</button>
                </div>
            <div class="keyboard-row">
                <button class="number keyboard-key keyboard-key--white" @click="appendSymbol('1')">1</button>
                <button class="number keyboard-key keyboard-key--white" @click="appendSymbol('2')">2</button>
                <button class="number keyboard-key keyboard-key--white" @click="appendSymbol('3')">3</button>
                <button class="keyboard-key keyboard-key--orange" @click="handleSign('+')">+</button>
                </div>
            <div class="keyboard-row">
                <button class="keyboard-key keyboard-key--white keyboard-key--double" @click="appendSymbol('0')">0</button>
                <button class="keyboard-key keyboard-key--white" @click="convertDecimal()">.</button>
                <button class="keyboard-key keyboard-key--orange" @click="handleSign('=')">=</button>
            </div>
        </div>
    </div>
     </div>

</template>

<script>
export default {
    data() {
        return {
            current: '0',
            previous: null,
            sign: null,
            clickedSign: false
        }
    },
    methods: {
        clearDisplay() {
            this.current = '0'
            this.previous = null
            this.sign = null
            this.clickedSign = false
        },
        appendSymbol(number) {
            if (this.clickedSign) {
                this.clickedSign = false
                this.current = number
            } else {
                this.current = this.current === '0' ? number : `${this.current}${number}`
            }
        },
        convertDecimal() {
            if (this.clickedSign) {
                this.current = '0.'
                this.clickedSign = false
            }
            if (this.current.indexOf('.') === -1 && !!this.current) {
                this.current += '.'
            }
        },
        changeSign() {
            this.current = this.current.charAt(0) === '-' ? this.current.slice(1) : `-${this.current}`
        },
        convertPercent() {
            this.current = `${parseFloat(this.current) / 100}`
        },
        handleSign(newSign) {
            let numberValue = parseFloat(this.current);

            if(isNaN(numberValue)){
                numberValue = 0;
            }
            if (this.sign && this.clickedSign) {
                this.sign = newSign
            }
            if (this.previous == null) {
                this.previous = numberValue;
            } else if (this.sign) {
                const result = this.calculate(this.previous, numberValue, this.sign)
                this.previous = result;
            }
            this.clickedSign = true;
            this.sign = newSign;
        },
        calculate(first, second, sign) {
            this.setResult(first,sign,second);
        },
        setResult(first,sign,second){
            this.axios.post('/api/calculator',{
              FirstNumber:first,
              SecondNumber:second,
              Sign:sign
              
            }).then(({data})=>{
                this.current = data;
                this.$emit('refreshHistory');
            }).catch(error=>{
                let response = error.response;
                let {title} = response.data; 
                let {errors} = response.data;

                if(title === 'DivideByZero'){
                    this.current = errors.SecondNumber;
                }
            });
        }
    }
}
</script>

<style lang="scss">
.keyboard-key{
  width:50px;
  height:50px;
}
.display-numbers{
  width:200px;
}
</style>
