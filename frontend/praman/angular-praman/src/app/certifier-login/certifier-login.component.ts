import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { GetInfoService } from '../services/get-info.service'
import { Router } from '@angular/router';

@Component({
  selector: 'app-certifier-login',
  templateUrl: './certifier-login.component.html',
  styleUrls: ['./certifier-login.component.css']
})
export class CertifierLoginComponent implements OnInit {

  public certifierLoginForm: FormGroup;
  res = <any>{};

  constructor(private formBuilder: FormBuilder,private getInfoService: GetInfoService,private route : Router) { }

  ngOnInit(): void {
    this.certifierLoginForm = this.formBuilder.group({
      uid: ['', [Validators.required]],
      password: ['',[Validators.required]]
    });
  }

  onSubmit(){
    if(this.certifierLoginForm.valid){
      this.getInfoService.certifierLogin(this.certifierLoginForm.value).subscribe((data) => { 
        this.res = data;
        if(this.res.success === true ){
          localStorage.clear();
          this.route.navigate(["certifier",this.res.name]);
          localStorage.setItem("address",this.res.address);
          localStorage.setItem("token",this.res.token);
        }
      });
    }
  }

}
