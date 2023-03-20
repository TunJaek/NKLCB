<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<title>배달•장보기</title>
<link rel="stylesheet" href="resources/css/question.css">
</head>
<body>
<div style = "border:1px solid black; margin-top:100px; height:700px; width:500px; margin-left:auto;margin-right:auto;background-color: rgb(237, 168, 132)">
<div ng-app="coolform" class="wrapper">
  
  <div cool-form>
    <div class="q-title">배달•장보기</div>
    <div ng-repeat="q in questions" class="question">
      <label>
        <span class="q-text">
        {{q.question}}
          <span class="q-answer">
          {{q.answer}}
          </span>
        </span>
        <input type ="text" id="q{{$index}}" ng-model="q.answer">
        <span class="q-back" ng-click="open($index)"><</span>
      </label>
      <span class="q-next" ng-click="open($index+1)">></span>  
    </div>
    <div class="q-after">
      <hr>
      <div class="q-confirm-text">선택하신 항목이 맞으십니까?</div>
      <div class="q-confirm-button">네</div>
    </div>
  </div>
  <center ng-show="activequestion > -1 && activequestion < questions.length"></center>
  
</div>
<script>
var coolform = angular.module('coolform', []);
coolform.directive('coolForm', function($timeout) {
    var ctrl = function($scope, $element, $attributes) {
      $scope.questions = [];
      $scope.activequestion = -1;
      $scope.answering = true;
      
      $scope.questions.push({'question': '어떤 서비스가 필요하신가요?'});
      $scope.questions.push({'question': '구매하실 물품 목록을 입력해주세요.'});
      $scope.questions.push({'question': '상품을 구매 할 지역를 입력해주세요.'});
      $scope.questions.push({'question': '상품을 배달 할 지역를 입력해주세요.'});
      $scope.questions.push({'question': '기타 사항이 있으시면 입력해주세요.'});
      
      function removeOpen() {
        for(i=0;i<qs.length;i++){
          angular.element(qs[i]).removeClass('open');
        }
      }
      
      var scrolle = document.getElementById('form-wrapper');
      var qs = document.getElementsByClassName('question');
      
      $scope.open = function(order) {
        removeOpen();
        if (order >= $scope.questions.length || order < 0) {
          $scope.answering = false;
          if ($element.hasClass('answering')) {
            $element.removeClass('answering');
            $scope.activequestion = $scope.questions.length+1;
          }
        } else {
          $scope.answering = true;
          if (!$element.hasClass('answering')) {
            $element.addClass('answering');
          }
          //document.activeElement.blur();
          $scope.activequestion = order;
          var offset = qs[0].offsetTop;
          if(order !== 0) {offset = qs[order-1].offsetTop;}
          scrollToAndFocus(scrolle, offset, 500, order);
          if (!angular.element(qs[order]).hasClass('open')) {
            angular.element(qs[order]).addClass('open');
          }
        }

      }
      
      function scrollToAndFocus(element, to, duration, focus) {
          if (duration <= 10) {
            document.getElementById('q'+(focus)).focus();
            return;
          }
          var difference = to - element.scrollTop;
          var perTick = difference / duration * 10;
          window.setTimeout(function() {
              element.scrollTop = element.scrollTop + perTick;
              if (element.scrollTop === to) return;
              scrollToAndFocus(element, to, duration - 10, focus);}, 10);
      }
      
      
      var handler = function(e){
        if(e.keyCode === 37) {
          //left arrow
          e.preventDefault(); 
          $scope.$apply(function() {
            $scope.open($scope.activequestion-1);
          });
        }     
        if(e.keyCode === 39) {
          //right arrow
          e.preventDefault(); 
          $scope.$apply(function() {
            $scope.open($scope.activequestion+1);
          });
        }
        if(e.keyCode === 13) {
          //enter
          e.preventDefault(); 
          $scope.$apply(function() {
            $scope.open($scope.activequestion+1);
          });
        }
        if (e.keyCode == 9) {
          //tab
          e.preventDefault(); 
          $scope.$apply(function() { $scope.open($scope.activequestion+1);
          });
        } 
      };

      
      $element.on('keydown', handler);
      $scope.$on('$destroy',function(){
        $element.off('keydown', handler);
      });
      
      
      setTimeout(function() {
        $scope.activequestion++;
        $scope.$apply(function(){
          $scope.open($scope.activequestion);
        });
      }, 2000);
    };
    return {
      restrict: 'EA',
      replace: true,
      transclude: true,
      link: ctrl,
      template: '<div ng-transclude id="form-wrapper" class="answering"></div>'
    };

  });
  
</script>
</body>
</html>